# Configuration

We love **Convention over Configuration** paradigm our favorite framework Ruby on Rails follows.
This article proposes some approaches for **Convention _for_ Configuration**.

## Application Configuration

- use gem `config` - https://github.com/rubyconfig/config
- set `AppConfig` as a more unique name for the constant and enable `fail_on_missing` to avoid missing configs:
```ruby
# config/initializers/config.rb
Config.setup do |config|
  config.const_name = 'AppConfig'
  config.fail_on_missing = true
end
```
- use `host` as the first application-wide setting:
```ruby
# config/settings.yml
host: example.com

# config/settings/development.yml
host: example.localhost

# usage
# config/environments/<env_name>.rb
config.action_mailer.default_url_options = {
  host: AppConfig.host
}
```

## Credentials and Secrets

Credentials and Secrets should never be committed into any repository, at least in unencrypted way.
There several ways to store such kind of sensitive data:

* Rails [Custom Credentials](https://guides.rubyonrails.org/security.html#custom-credentials)
* [ENV Variables](#env-variables)
* Other secure storages, e.g. [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/)

We recommend pulling Credentials and Secrets into appropriate application or service configurations,
instad of calling credentials storage directly inside the code.
This approach will provide clean and unified access to all config settings, e.g.:

```ruby
# config/settings.yml
some_api:
  uri: 'https://api.example.com'
  key: <%= Rails.application.credentials.some_api_key! %>
  token: <%= ENV.fetch('SOME_API_TOKEN') %>

# usage
AppConfig.some_api[:uri]
AppConfig.some_api[:key]
AppConfig.some_api[:token]
```

## ENV Variables

ENV Variables is a classic way to store environment-specific settings, secrets, or just even some application settings.

- use gem `dotenv` - https://github.com/bkeepers/dotenv
- file `.env` should be committed to a repository as a reference of all variables used in the project with empty or default values

## Class/Object Configuration

* [`ActiveSupport::Configurable`](https://api.rubyonrails.org/classes/ActiveSupport/Configurable.html)
* [`Dry::Configurable`](https://dry-rb.org/gems/dry-configurable/)

## Service Module Configuration

See [Service Modules](https://github.com/ergoserv/handbook/blob/master/guides/service_modules.md).

In case you need extend your Service Modules with configuratoin, concider the following approaches
or use `Service` extension by [AuxiliaryRails](https://github.com/ergoserv/auxiliary_rails#service-modules).

We recommend starting with constant as a fastest and simple approach, and then switch to application or service configuration when you need more flexibility.
Thankfully to the unified interface, you won't need to change the code calling for the configs,
because any of the approaches below will provide with access to config value via `MyService.config.key`.

- Constant ("plain old ruby constant") + method `config` for a convenient and unified interface:
```ruby
# services/my_service.rb
module MyService
  CONFIG = {
    key: 'value'
  }

  module_function

  def config
    @config ||= ActiveSupport::OrderedOptions.new.update(CONFIG)
  end
end
```

- Section in the application configuration file:
```ruby
# config/settings.yml
services:
  my_service:
    key: 'value'

# services/my_service.rb
module MyService
  module_function

  def config
    @config ||= AppConfig.services.my_service
  end
end
```

- Dedicated configuration file for a Service Module:
```ruby
# config/services/my_service.yml
default: &default
  key: 'value'

development:
  <<: *default

test:
  <<: *default

production:
  <<: *default

# services/my_service.rb
module MyService
  module_function

  def config
    @config ||= Rails.application.config_for('services/my_service')
  end
end
```

## References
- [Service Modules](https://github.com/ergoserv/handbook/blob/master/guides/service_modules.md)
- [AuxiliaryRails](https://github.com/ergoserv/auxiliary_rails)
- https://github.com/rubyconfig/config
- https://github.com/bkeepers/dotenv
- https://api.rubyonrails.org/classes/ActiveSupport/OrderedOptions.html
- https://api.rubyonrails.org/classes/Rails/Application.html#method-i-config_for
- https://guides.rubyonrails.org/security.html#custom-credentials
- https://guides.rubyonrails.org/configuring.html#custom-configuration
- https://api.rubyonrails.org/classes/ActiveSupport/Configurable.html
- https://dry-rb.org/gems/dry-configurable/
- https://kukicola.io/posts/useful-active-support-features-you-may-not-have-heard-of/
