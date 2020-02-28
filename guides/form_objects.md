# Form Objects

## Introduction

Form Objects is a solution to handle and process custom requests with custom validations, multi-model requests, etc.

## Conventions

* Forms go under the `app/forms` directory.
* Form name should have suffix `Form` (e.g.: `app/forms/company_registration_form.rb` file will define `CompanyRegistrationForm`)
* Form may encapsulate business logic for processing the request, but for complex cases, it is better to consider separate class around the [Command Objects](../guides/command_objects.md) layer.
* Form may have `populate` method where the logic of pre-filling form from a model or other sources can be defined.
* Use [auxiliary_rails](https://github.com/ergoserv/auxiliary_rails) gem.

## References

* [auxiliary_rails](https://github.com/ergoserv/auxiliary_rails)
* [ActiveModel Form Objects](https://thoughtbot.com/blog/activemodel-form-objects)
* [Rectify / Form Objects](https://github.com/andypike/rectify#form-objects)
