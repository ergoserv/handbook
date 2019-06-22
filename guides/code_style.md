# Code Style

At [ErgoServ](https://www.ergoserv.com) we value our code quality. These style guides help to keep our code
consistent and looking beautiful. The guides are derived from practices and
conventions generally accepted and used by the wider community.

## Getting Started

We understand that no two projects are the same, each one a little different to
the next. With that in mind, we recommend using these guides as starting point.
They can be tweaked and moulded on a per project basis, but make sure everyone
on the team is comfortable with any adjustments you make.

## Linting

We use a number of tools to enforce style compliance:

  * RuboCop, for Ruby lints
  * RuboCop RSpec, for RSpec lints

First, you need to add the gems to your project's `Gemfile`:

```ruby
group :development do
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end
```

### Configs

Then you need to add some configs that implement our styles.

The following is a list of configuration files you're encouraged to use in a new project:

* [rubocop_template.yml](https://github.com/ergoserv/auxiliary_rails/blob/master/lib/generators/auxiliary_rails/templates/rubocop/rubocop_template.yml) -> `.rubocop.yml`
* [rubocop_auxiliary_rails_template.yml](https://github.com/ergoserv/auxiliary_rails/blob/master/lib/generators/auxiliary_rails/templates/rubocop/rubocop_auxiliary_rails_template.yml) -> `.rubocop_auxiliary_rails.yml`

These files should go into your project's root directory.
`.rubocop_auxiliary_rails.yml` - should not be modified in order to be able to be updated it when needed.

Also, you can install and use our gem [`auxiliary_rails`](https://github.com/ergoserv/auxiliary_rails) to generate these configs.

## Conventions and Recommendations

* [Models](models.md)
* [Variables](variables.md)

### General

* Be positive where possible. Prefer `if` over `unless`, `only:` over `except:` (e.g. `if var.present?` is better than `unless var.blank?`).
* Use alphabetic order where and if possible (definitions, keys, translations).

### Configurations

* Name initializers according to the name of their gem.

### Controllers

* Avoid using callbacks for setting instance variables. Use them only for changing the application flow, such as redirecting if a user is not authenticated.
* Use `private` instead of `protected` when defining controller methods.

### Databases

* Name date columns with `_on` suffixes.
* Name datetime columns with `_at` suffixes.
* Name time columns (referring to a time of day with no date) with `_time` suffixes.
* Don't change a migration after it has been merged into master if the desired change can be solved with another migration.

#### Mailers

* Use `ApplicationMailer` as "abstract" class (e.g. set global config, shared methods, but avoid adding mailing methods there).
* Always put subjects to locale files, they are pulled automatically by `action_name`. Use [default_i18n_subject](https://api.rubyonrails.org/v5.2.3/classes/ActionMailer/Base.html#method-i-default_i18n_subject) when you need some interpolation.
* Use separate locale file for mailer translations (`config/locles/mailers.en.yml`).
* Use `application_mailer` translation scope to group strings used in all/many mailers.

### Testing / RSpec

#### Multiline `expect`

```
expect { true }
  .not_to(change { false })
```

### Views

* Place application-wide partials to the `app/views/application/` directory, leaving layout-only partials (like `_header`, `_sidebar`, etc) in the `app/views/layouts/` directory.
* Place layout partials to separate directories (e.g. `app/views/layouts/application/`, `app/views/layouts/landing/`, etc).
* Don't use `()` in views for first-level helpers (e.g. `image_tag 'image.jpg`, `link_to 'Profile', user_path(user)`).
* Avoid direct calls of object or class methods in views, but if you still need to, then use `()` for arguments (e.g. `User.human_attribute_name(:name)`).
* Avoid using instance variables (`@var`) in partials. Pass local variables to partials from view templates.

## References

* [The Ruby Style Guide](https://github.com/rubocop-hq/ruby-style-guide)
* [The Rails Style Guide](https://github.com/rubocop-hq/rails-style-guide)
* [The RSpec Style Guide](https://github.com/rubocop-hq/rspec-style-guide)
