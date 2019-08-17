# Service Objects

## Introduction

Service Objects is a solution to decompose business logic of the application from other layers of the application.

## Conventions

* Services go under the `app/services` directory.
* Service name should have suffix `Service` (e.g.: `app/services/order_service.rb` file will define `module OrderService`)
* Basic service file should define module (e.g.: `module OrderService`, `module GalleryService`)
* Basic service module may contain constants, configurations, class methods
* Use subdirectories to store subclasses of the service (e.g.: `gallery_service.rb`, `gallery_service/facebook_repository.rb`, etc)

## Examples

### Example #1: GalleryService

You have task to render user's photos. User have 3 sources of photos - Facebook, Instagram, and uploaded into our database.

```ruby
# app/service/gallery_service.rb
module GalleryService
  def self.photos(user, repository_name)
    repository_class =
      "GalleryService::#{repository_name.to_s.camelize}Repository".constantize

    repository = repository_class.new(user: user)
    unless repository.connected?
      repository = EmptyRepository.new(user: user)
    end
    repository.fetch_all
  end
end

# app/service/gallery_service/error.rb
# see Error Handing
module GalleryService
  class Error < ApplicationError
  end
end

# app/service/gallery_service/photo_struct.rb
module GalleryService
  class PhotoStruct < OpenStruct
  end
end

# app/service/gallery_service/abstract_repository.rb
module GalleryService
  class AbstractRepository
    attr_reader :user

    def initialize(user:)
      @user = user
    end

    def connected?
      raise NotImplementedError
    end

    def fetch_all
      raise NotImplementedError
    end
  end
end

# app/service/gallery_service/database_repository.rb
module GalleryService
  class DatabaseRepository < AbstractRepository
    def connected?
      Picture.connected? # ActiveRecord::Base.connected?
    end

    def fetch_all
      photos = user.pictures

      photos.map do |photo|
        PhotoStruct.new(
          uid: photo.id,
          repository: :database,
          url: build_photo_path(photo),
        )
      end
    end

    private

    def build_photo_path(photo)
      # ...
    end
  end
end

# app/service/gallery_service/empty_repository.rb
module GalleryService
  class EmptyRepository < AbstractRepository
    def connected?
      true
    end

    def fetch_all
      []
    end
  end
end

# app/service/gallery_service/facebook_repository.rb
module GalleryService
  class FacebookRepository < AbstractRepository
    def connected?
      user.facebook_connected?
    end

    def fetch_all
      photos = facebook_service.photos

      photos.map do |photo|
        PhotoStruct.new(
          uid: photo['id'],
          repository: :facebook,
          url: photo['images'].first['source']
        )
      end
    end

    private

    def facebook_service
      unless connected?
        raise Error, "Facebook is not connected for user #{user}"
      end

      @facebook_service ||= FacebookService.new(user.facebook_token)
    end
  end
end

# app/service/gallery_service/instagram_repository.rb
module GalleryService
  class InstagramRepository < AbstractRepository
    def connected?
      user.instagram_connected?
    end

    def fetch_all
      photos = instagram_service.photos

      photos.map do |photo|
        PhotoStruct.new(
          uid: photo['id'],
          repository: :instagram,
          url: photo.images.standard_resolution.url
        )
      end
    end

    private

    def instagram_service
      unless connected?
        raise Error, "Instagram is not connected for user #{user}"
      end

      @instagram_service ||= InstagramService.new(user.instagram_token)
    end
  end
end
```


### Example #2: ImportService

```ruby
# app/services/import_service.rb
module ImportService
  AVALIABLE_ADAPTERS = %w(yandex_yml yandex_csv yandex_scsv yandex_tsv)

  def self.factory(object)
    case
    when object.is_a?(Hash)
      case object[:adapter]
      when 'yandex_csv'
        ImportService::YandexCsv::Adapter.new(object)
      when 'yandex_scsv'
        ImportService::YandexCsv::Adapter.new(object.merge({col_sep: ";"}))
      when 'yandex_tsv'
        ImportService::YandexCsv::Adapter.new(object.merge({col_sep: "\t"}))
      else
        ImportService::YandexYml::Adapter.new(object)
      end
    else
      raise
    end
  end
end

# app/services/import_service/abstract_adapter.rb
module ImportService
  class AbstractAdapter

    def initialize(options = {})
      # ...
    end

    def call
      # ...
    end

    protected

    def find_category(category)
      raise "Category finder should be implemented"
    end

    def initialize_category(category)
      # ...
    end

    def find_product_category(offer)
      raise "Product Category finder should be implemented"
    end

    def create_or_update_category(category)
      # ...
    end

    def find_product(offer)
      ShopProduct.unscoped.where(shop_id: shop.id, ouid: offer.id).first
    end

    def initialize_product(offer)
      # ...
    end

    def create_or_update_product(offer)
      # ...
    end
  end
end

# app/services/import_service/yandex_csv_adapter.rb
module ImportService
  module YandexCsv
    class Adapter < ImportService::AbstractAdapter
      attr_accessor :csv_options

      def initialize(options = {})
        super
        @csv_options = {
          headers: true,
          col_sep: (options[:col_sep] || ',')
        }
      end
    end
  end
end
```

The whole list of files of this service is:
```
abstract_adapter.rb
abstract_category.rb
abstract_element.rb
abstract_offer.rb
yandex_csv.rb
yandex_csv_adapter.rb
yandex_csv_category.rb
yandex_csv_offer.rb
yandex_yml.rb
yandex_yml_adapter.rb
yandex_yml_category.rb
yandex_yml_element.rb
yandex_yml_offer.rb
```
