# Command Objects

## Introduction

*Commands* (also known as *Service Objects*) are the place for the application's business logic. They allow you to simplify your models and controllers and allow them to focus on what they are responsible for. A Command should encapsulate a single user task such as registering for a new account, placing an order, publishing post.

## Conventions

* Commands go under the `app/commands` directory.
* Command name should have suffix `Command` .
* Command name should contain verb (e.g. `PostPublishCommand`).
* Command should have only one public method (`#perform`).
* Keep method `#perform` short, simple and clear.
* Put all business logic into private methods with a very clear, self-explanatory and meaninful names.
* Use [auxiliary_rails](https://github.com/ergoserv/auxiliary_rails) gem.

## References

* [auxiliary_rails](https://github.com/ergoserv/auxiliary_rails)
* [Command pattern Wiki](https://en.wikipedia.org/wiki/Command_pattern)
* [Rectify / Ccommands](https://github.com/andypike/rectify#commands)
