# Form Objects

## Introduction

Form Objects is a solution to handle and process custom requests with custom validations, multi-model requests, etc.

## Conventions

* Forms go under the `app/forms` directory.
* Form name should have suffix `Form` (e.g.: `app/services/CompanyRegistrationForm.rb` file will define `CompanyRegistrationForm`)
* Form may incaplulate business logic for proccessing the request, but for complex cases it is better to concider separate class around the [Service Objects](guides/service_objects.md) layer.

## Example

```ruby
# app/forms/CompanyRegistrationForm.rb
class CompanyRegistrationForm
  include ActiveModel::Model

  attr_accessor
    :company_name,
    :email,
    :terms_of_service

  validates :company_name, presence: true
  validates :email, presence: true, email: true
  validates :terms_of_service, acceptance: true

  def submit
    if valid?
      # Do something interesting here
      # - create company
      # - send notifications
      # - log events, etc.
    end
  end

  private

  def create_comany
    # ...
  end
end
```

## Links

* [ActiveModel Form Objects](https://thoughtbot.com/blog/activemodel-form-objects)
