# Command Objects

## Introduction

*Commands* (also known as *Service Objects*) are the place for the application's business logic. They allow you to simplify your models and controllers and allow them to focus on what they are responsible for. A Command should encapsulate a single user task such as registering for a new account, placing an order, publishing post.

## Conventions

* Commands go under the `app/commands` directory. In case when a command is a part of a module, consider placing it into the directory structure suggested by [Service Modules](https://github.com/ergoserv/handbook/blob/master/guides/service_modules.md).
* Command name should have suffix `Command`.
* Command name should contain a verb (e.g. `PostPublishCommand`).
* Command should have only one public method (`#perform`).
* Focus on readability of the `#perform` method, keep it short, simple and clear.
* Put all business logic into private methods with a very clear, self-explanatory and meaningful names.
* Use [auxiliary_rails](https://github.com/ergoserv/auxiliary_rails) gem.

## References

* [auxiliary_rails](https://github.com/ergoserv/auxiliary_rails)
* [Command pattern Wiki](https://en.wikipedia.org/wiki/Command_pattern)
* [Rectify / Ccommands](https://github.com/andypike/rectify#commands)
