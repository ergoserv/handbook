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

### Testing / RSpec

#### Multiline `expect`

```
expect { true }
  .not_to(change { false })
```

## References

* [The Ruby Style Guide](https://github.com/rubocop-hq/ruby-style-guide)
* [The Rails Style Guide](https://github.com/rubocop-hq/rails-style-guide)
* [The RSpec Style Guide](https://github.com/rubocop-hq/rspec-style-guide)
