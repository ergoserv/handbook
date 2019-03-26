# Building an API

## Introduction

API is an important part of web applications. They provide interfaces for communication with the app from the outside. While Rails has built-in support for API application, we believe that `grape` gem provides a cleaner and more isolated approach to build APIs.

## Conventions

* API files go under the `app/apis` directory.
* API files go under a subdirectory named by API purpose + version (e.g. `mobile_v1`), even if there is only one API is foreseeing now.
* Each API module directory should contain `api.rb` and class `API` which defines configurations and mounts all needed resources and helpers for this API.
* Each API subdirectory contains predefined directories (`resources/`, `entities/`, `helpers/`) to store corresponding classes.
* Each API resource should be stored in separate file and class (e.g. `UsersAPI`, `OrdersAPI`, `RegistrationsAPI`, etc) and be inherited from `Grape::API.`
* Entities are stored in `entities/` directory and be inherited from `Grape::Entity`. Entity name should correspond with the model it is related to (e.g.: `UserEntity`, `UserExtendedEntity`).


### Directory Structure

```
apis/
  mobile_v1/ - API for mobile apps
    resources/
      sessions_api.rb
    entities/
      user_entity.rb
    helpers/
      application_api_helpers.rb
    api.rb
  mobile_v2/ - API for mobile apps (version 2)
  twilio_v1/ - API for webhooks and callbacks from Twilio
    resources/
    entities/
    helpers/
    api.rb
```

### Example Classes

```ruby
# apis/mobile_v1/api.rb
module MobileV1
  class API < Grape::API
    helpers MobileV1::ApplicationAPIHelpers

    mount MobileV1::SessionsAPI
  end
end

# apis/mobile_v1/resources/sessions_api.rb
module MobileV1
  class SessionsAPI < Grape::API
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

# apis/mobile_v1/helpers/application_api_helpers.rb
module MobileV1
  class ApplicationAPIHelpers
  end
end

# apis/mobile_v1/entities/user_entity.rb
module MobileV1
  class UserEntity < Grape::Entity
    expose :email
  end
end
```

## Gems

* [grape](https://github.com/ruby-grape/grape)
* [grape-entity](https://github.com/ruby-grape/grape-entity)
* [grape-swagger-rails](https://github.com/ruby-grape/grape-swagger-rails)

## References

* [JSON:API](https://jsonapi.org) - A specification for building APIs in JSON.
