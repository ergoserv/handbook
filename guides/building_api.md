# Building an API

## Introduction

API is an important part of web applications. They provide interfaces for communication with the app from the outside. While Rails has built-in support for API application, we believe that `grape` gem provides a cleaner and more isolated approach to build APIs.

## Conventions

* API files go under the `app/apis` directory.
* API files go under a subdirectory named by API purpose + version (e.g. `app_v1_api`, `mobile_v1_api`), even if there is only one API is foreseeing now.
* Each API module directory should contain `api.rb` and class `API` which defines configurations and mounts all needed resources and helpers for this API.
* Each API subdirectory contains predefined directories (`resources/`, `entities/`, `helpers/`) to store corresponding classes.
* Each API resource should be stored in separate file and class (e.g. `UsersResource`, `OrdersResource`, `RegistrationsResource`, etc) and be inherited from `Grape::API.`
* Entities are stored in `entities/` directory and be inherited from `Grape::Entity`. Entity name should correspond with the model it is related to (e.g.: `UserEntity`, `UserExtendedEntity`).


### Directory Structure

```
apis/
  app_v1_api/ - API for generic purpose (default)
    resources/
      sessions_resource.rb
      users_resource.rb
    entities/
      user_entity.rb
    helpers/
      api_helpers.rb
      users_api_helpers.rb
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
```

### Example Classes

```ruby
# apis/app_v1_api/api.rb
module AppV1API
  class API < Grape::API
    helpers AppV1API::APIHelpers
    helpers AppV1API::UsersAPIHelpers

    mount AppV1API::SessionsResource
  end
end

# apis/app_v1_api/resources/sessions_resource.rb
module AppV1API
  class SessionsResource < Grape::API
    resource :sessions do
      desc 'Login user'
      params do
        requires :email, type: String, desc: 'User email'
        requires :password, type: String, desc: 'User password'
      end
      post do
        # login user
        present user, with: UserEntity
      end

      desc 'Logout user'
      delete do
        # logout user
      end
    end
  end
end

# apis/app_v1_api/entities/user_entity.rb
module AppV1API
  class UserEntity < Grape::Entity
    expose :email
  end
end

# apis/app_v1_api/helpers/api_helpers.rb
module AppV1API
  class APIHelpers
  end
end

# apis/app_v1_api/helpers/users_api_helpers.rb
module AppV1API
  class UsersAPIHelpers
  end
end

## MobileV1API ##

# apis/mobile_v1_api/api.rb
module MobileV1API
  class API < Grape::API
    helpers MobileV1API::APIHelpers
    helpers MobileV1API::UsersAPIHelpers

    mount MobileV1API::SessionsResource
  end
end
```

## Gems

* [grape](https://github.com/ruby-grape/grape)
* [grape-entity](https://github.com/ruby-grape/grape-entity)
* [grape-swagger-rails](https://github.com/ruby-grape/grape-swagger-rails)

## References

* [JSON:API](https://jsonapi.org) - A specification for building APIs in JSON.
