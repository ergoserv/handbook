# Command Objects

Implementation of [Command pattern](https://en.wikipedia.org/wiki/Command_pattern).

## Conventions

@TBD

## Examples

```ruby
# app/commands/application_command.rb
class ApplicationCommand
  extend ActiveModel::Naming

  class << self
    def call(*args)
      cmd = new(*args)
      cmd.call
    end
  end

  def call
    _execute
  end

  def execute
    raise NotImplementedError
  end

  def context
    @_context ||= {}
  end

  def errors
    @_errors ||= ActiveModel::Errors.new(self)
  end

  def fail!
    @_success = false
  end

  def validate
    @_valid = true
  end

  def authenticate!
  end

  def valid?
    !!@_valid
  end

  def executed?
    !!@_executed
  end

  def success?
    !!@_success && errors.empty?
  end

  def failure?
    !success?
  end


  # The following methods are needed to be minimally implemented for ActiveModel::Errors

  def read_attribute_for_validation(attr)
    context[attr]
  end

  def self.human_attribute_name(attr, options = {})
    attr
  end

  def self.lookup_ancestors
    [self]
  end

  protected

  def _execute
    raise 'Command was already executed' if executed?
    validate && authenticate!
    execute if valid?
    @_executed = true
    self
  end

  def auth_object
    @_auth_object ||= context[:auth_object]
  end

  def auth_object!
    auth_object || raise('`auth_object` is not set')
  end
end

# app/commands/register_user_command.rb
class RegisterUserCommand < ApplicationCommand
  attr_reader :user

  def initialize(email:, password:)
    @email = email
  end

  def execute
    if context[:ip_address].blank?
      errors.add(:ip_address, :blank, message: "cannot be nil")
      fail!
    else
      # register user
      @user = {email: @email}
    end
  end
end

### usage ###

class RegistrationsController
  def register
    cmd = RegisterUserCommand.new(params)
    cmd.context[:ip_address] = '123.123.123.123'
    cmd.call

    if cmd.success? # or if cmd.call.success?
     redirect_to user_path(cmd.user) and return
    else
      @errors = cmd.errors
    end
  end
end
```

## References

* [Command pattern Wiki](https://en.wikipedia.org/wiki/Command_pattern)
* [rectify#commands](https://github.com/andypike/rectify#commands)