# Building an API

## Introduction

API is an important part of web applications. They provide interfaces for communication with the app from the outside. While Rails has built-in support for API application, we believe that `grape` gem provides a cleaner and more isolated approach to build APIs.

## Conventions

* API files go under the `app/apis` directory.
* API files go under a subdirectory named by API purpose + version (e.g. `app_v1_api`, `mobile_v1_api`), even if there is only one API is foreseeing now.
* Each API module directory should contain `api.rb` file with class `API` which defines configurations and mounts all needed resources and helpers for this API.
* Each API subdirectory contains predefined directories (`resources/`, `entities/`, `helpers/`) to store corresponding classes.
* Each API resource are stored in separate file (e.g. `UsersResource`, `OrdersResource`, `RegistrationsResource`, etc) and class which is inherited from `Grape::API.`.
* Each API resource class (e.g. `UsersResource`) defines a single resource (e.g. `resource :users do ... end`).
* Entities are stored in `entities/` directory and inherited from `Grape::Entity` class.
* Each API resource, entity class or helpers module class are wrapped into corresponding module (e.g. `AppV1API::Resources`, `AppV1API::Entities`, `AppV1API::Helpers`).
* Entity class name corresponds with the model it is related to (e.g. `UserEntity` for `User` model, `OrderEntity` for `Order` model).
* Specs directory structure follows same directory names (e.g. `spec/apis/app_v1_api/`, `spec/apis/mobile_v1_api/`).

### Directory Structure

```
apis/
  app_v1_api/ - API for a generic purpose (default)
    resources/
      sessions_resource.rb
      users_resource.rb
    entities/
      user_entity.rb
    helpers/
      api_helper.rb
      users_api_helper.rb
    api.rb
  mobile_v1_api/ - API for mobile apps (version 1)
   ...
  mobile_v2_api/ - API for mobile apps (version 2)
   ...
  twilio_v1_api/ - API for webhooks and callbacks from Twilio
    resources/
    entities/
    helpers/
    api.rb
spec/
  apis/
    app_v1_api/
      resources/
        sessions_resource_spec.rb
    twilio_v1_api/
      resources/
        *_resource_spec.rb
```

### Example Classes

```ruby
## AppV1API ##

# apis/app_v1_api/api.rb
module AppV1API
  class API < Grape::API
    helpers Helpers::APIHelper
    helpers Helpers::UsersAPIHelper

    mount Resources::SessionsResource
  end
end

# apis/app_v1_api/resources/sessions_resource.rb
module AppV1API::Resources
  class SessionsResource < Grape::API
    resource :sessions do
      desc 'Login user'
      params do
        requires :email, type: String, desc: 'User email'
        requires :password, type: String, desc: 'User password'
      end
      post do
        # login user
        present user,
          with: ApiV1API::Entities::UserEntity
      end

      desc 'Logout user'
      delete do
        # logout user
      end
    end
  end
end

# apis/app_v1_api/entities/user_entity.rb
module AppV1API::Entities
  class UserEntity < Grape::Entity
    expose :email
  end
end

# apis/app_v1_api/helpers/api_helper.rb
module AppV1API::Helpers
  class APIHelper
    # generic API helpers
  end
end

# apis/app_v1_api/helpers/users_api_helper.rb
module AppV1API::Helpers
  class UsersAPIHelper
    # API helpers specific for user resource
  end
end

# spec/apis/app_v1_api/resources/sessions_resource_spec.rb
require 'rails_helper'

describe AppV1API::Resources::SessionsResource, type: :request do
  describe 'POST /api/v1/sessions' do
    # ...
  end

  describe 'DELETE /api/v1/sessions' do
    # ...
  end
end

## MobileV1API ##

# apis/mobile_v1_api/api.rb
module MobileV1API
  class API < Grape::API
    helpers Helpers::APIHelper
    helpers Helpers::UsersAPIHelper

    mount Resources::SessionsResource
  end
end
```

## References

* [Gems for APIs](libraries.md#api) - ErgoServ's list of recommended gems.
* [httpstatuses.com](https://httpstatuses.com) - HTTP Status Codes is an easy to reference database of HTTP Status Codes with their definitions and helpful code references all in one place.
* [JSON:API](https://jsonapi.org) - A specification for building advanced APIs in JSON.
