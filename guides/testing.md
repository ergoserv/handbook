# Testing

We use [RSpec](https://rspec.info) framework for testing and
follow recommendations provided by [Better Specs](http://www.betterspecs.org).

## Factories

* Base factory should define only required and mandatory fields

## Code Style

```ruby
# Multiline `expect`
expect { true }
  .not_to(change { false })
```

## References

* [Better Specs](http://www.betterspecs.org)
* [Gems for Testing](libraries.md#testing)
* [The RSpec Style Guide](https://github.com/rubocop-hq/rspec-style-guide)
