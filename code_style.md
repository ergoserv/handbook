# Code Style

At ErgoServ we value our code quality. These style guides help to keep our code
consistent and looking beautiful. The guides are derived from practices and
conventions generally accepted and used by the wider community.

## Getting Started

We understand that no two projects are the same, each one a little different to
the next. With that in mind, we recommend using these guides as starting point.
They can be tweaked and moulded on a per project basis, but make sure everyone
on the team is comfortable with any adjustments you make.

## Linting

We use a number of tools to enforce style compliance:

  * Rubocop, for Ruby lints
  * SCSS Lint, for SCSS lints

First, you need to add the gems to your project's Gemfile:

```ruby
group :development, :test do
  gem 'rubocop', require: false
  gem 'scss_lint', require: false
end
```

### Configs

Then you need to add some configs that implement our styles.

The following is a list of configuration files you're encouraged to use in a new project:

* [.rubocop.yml](templates/.rubocop.yml)
* [.rubocop_ergoserv.yml](templates/.rubocop_ergoserv.yml)

These files should go into your project's root directory.
`.rubocop_ergoserv.yml` - should not be modified in order to be able to updated it when needed.
