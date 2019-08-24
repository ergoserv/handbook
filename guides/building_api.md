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
app/
  apis/
    app_v1_api/ - API for a generic purpose (default)
      entities/
        user_entity.rb
      helpers/
        api_helper.rb
        users_api_helper.rb
      resources/
        sessions_resource.rb
        users_resource.rb
      api.rb
    mobile_v1_api/ - API for mobile apps (version 1)
     ...
    mobile_v2_api/ - API for mobile apps (version 2)
     ...
    twilio_v1_api/ - API for webhooks and callbacks from Twilio
      entities/
      helpers/
      resources/
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

# app/apis/app_v1_api/api.rb
module AppV1API
  class API < Grape::API
    version 'v1'
    format :json
    rescue_from :all

    helpers Helpers::APIHelper
    helpers Helpers::UsersAPIHelper

    mount Resources::SessionsResource
  end
end

# app/apis/app_v1_api/resources/sessions_resource.rb
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

# app/apis/app_v1_api/resources/users_resource.rb
module AppV1API::Resources
  class UsersResource < Grape::API
    resource :users do
      desc 'Returns resource collection'
      get do
        # ...
      end

      # Nested Versioning if you need minor updates to API
      version 'v1.1' do
        desc 'Returns resource collection (API Version 1.1)'
        get do
          # ...
        end
      end
    end
  end
end

# app/apis/app_v1_api/entities/user_entity.rb
module AppV1API::Entities
  class UserEntity < Grape::Entity
    expose :email
  end
end

# app/apis/app_v1_api/helpers/api_helper.rb
module AppV1API::Helpers
  class APIHelper
    # generic API helpers
  end
end

# app/apis/app_v1_api/helpers/users_api_helper.rb
module AppV1API::Helpers
  class UsersAPIHelper
    # API helpers specific for user resource
  end
end

# config/routes.rb
mount AppV1API::API => '/api'

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

# app/apis/mobile_v1_api/api.rb
module MobileV1API
  class API < Grape::API
    version 'v1'
    format :json
    rescue_from :all

    helpers Helpers::APIHelper
    helpers Helpers::UsersAPIHelper

    mount Resources::SessionsResource
  end
end

# config/routes.rb
mount MobileV1API::API => '/api'
```

## HTTP headers and status codes

Some of the more commonly used HTTP status codes are:

#### Success codes

* `200 OK` — request has succeeded.
* `201 Created` — new resource has been created.
* `204 No Content` — no content needs to be returned (e.g. when deleting a resource).

#### Client error codes

* `400 Bad Request` — request is malformed in some way (e.g. wrong formatting of JSON, invalid request params, etc).
* `401 Unauthorized` — authentication failed (valid credentials are required).
* `403 Forbidden` — authorization failed (client/user is authenticated but does not have permissions for the requested resource or action).
* `404 Not Found` — resource could not be found.
* `422 Unprocessable Entity` — resource hasn't be saved (e.g. validations on the resource failed) or action can't be performed.

#### Server error codes

* `500 Internal Server Error` — something exploded in your application.

## References

* [Gems for APIs](libraries.md#api) - ErgoServ's list of recommended gems.
* [httpstatuses.com](https://httpstatuses.com) - HTTP Status Codes is an easy to reference database of HTTP Status Codes with their definitions and helpful code references all in one place.
* [JSON:API](https://jsonapi.org) - A specification for building advanced APIs in JSON.
