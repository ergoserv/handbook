
# Code Style

At [ErgoServ](https://www.ergoserv.com) we value our code quality. These style guides help to keep our code
consistent and looking beautiful. The guides are derived from practices and
conventions generally accepted and used by the wider community.

## Getting Started

We understand that no two projects are the same, each one a little different to
the next. With that in mind, we recommend using these guides as starting point.
They can be tweaked and molded on a per project basis, but make sure everyone
on the team is comfortable with any adjustments you make.

## Linting

We use a number of tools to enforce style compliance:

### RuboCop

Use our gem [`rubocop-ergoserv`](https://github.com/ergoserv/rubocop-ergoserv) to install all needed gems and generate configs.

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

### CSS/SCSS

* Use SCSS's class nesting always.

### Databases

* Name date columns with `_on` suffixes.
* Name datetime columns with `_at` suffixes.
* Name time columns (referring to a time of day with no date) with `_time` suffixes.
* Don't change a migration after it has been merged into master if the desired change can be solved with another migration.
* Use capital letters only for SQL keywords and functions when writing plain SQL.

## Internationalization (I18n)

* Keep `en.yml` as small as possible, specify here only `date`, `datetime`, `number`, `time` formats.
* Use `application.en.yml` and `application:` key to store application-wide tranlations.
* Use separate files to store translations (`activerecord.en.yml`, `helpers.en.yml`, `mailers.en.yml`, etc). Each file should contain corresponding root key (`activerecord`, `helpers`, `mailers`, etc).

#### Mailers Internationalization (I18n)

* Use `ApplicationMailer` as "abstract" class (e.g. set global config, shared methods, but avoid adding mailing methods there).
* Always put subjects to locale files, they are pulled automatically by `action_name`. Use [default_i18n_subject](https://api.rubyonrails.org/v5.2.3/classes/ActionMailer/Base.html#method-i-default_i18n_subject) when you need some interpolation.
* Use separate locale file for mailer translations (`config/locles/mailers.en.yml`).
* Use `application_mailer` translation scope to group strings used in all/many mailers.

### Rake Tasks

* Put all application rake tasks under the `namespace` named according to appliation. This will allow to separate them from all other tasks when you call `rake --tasks`.
* Use tasks tasks only to call command or service object, avoid putting any business logic into rake tasks.

### Testing / RSpec

#### Multi-line `expect`

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

* [`rubocop-ergoserv`](https://github.com/ergoserv/rubocop-ergoserv) - ErgoServ's shared configs for RuboCop.
* [The Ruby Style Guide](https://github.com/rubocop-hq/ruby-style-guide)
* [The Rails Style Guide](https://github.com/rubocop-hq/rails-style-guide)
* [The RSpec Style Guide](https://github.com/rubocop-hq/rspec-style-guide)
