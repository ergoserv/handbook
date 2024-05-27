# Error Handling

* [Ruby Exceptions](http://rubylearning.com/satishtalim/ruby_exceptions.html)
* [Rescue StandardError, Not Exception](https://thoughtbot.com/blog/rescue-standarderror-not-exception)

## ApplicationError

Sometimes for better error handling it is good to introduce a separate error class to decouple our errors from any other `StandardError`s. This can be done with a very simple class.

```ruby
# app/errors/application_error.rb
class ApplicationError < StandardError
end

# usage

raise ApplicationError

rescue ApplicationError => e
```

## ApplicationError (advanced)

And if you need errors to be more advanced and make them to be able to make custom reports, etc class can be extended with extra features:

```ruby
# app/errors/application_error.rb
class ApplicationError < StandardError
  attr_accessor :context
  attr_reader :code, :level, :original_error

  def initialize(msg = nil, code: nil, level: nil, original_error: nil, context: nil)
    super msg
    @code = code || original_error.try(:code)
    @level = level || original_error.try(:level)
    @original_error = original_error
    @context = context || {}
  end

  def friendly_message
    I18n.t('default', scope: 'application_errors.friendly_messages')
  end

  def notify!
    notify_airbrake
    notify_rails_logger
    notify_support if #...
    nil
  end

  def notify_airbrake
    # ...
  end

  def notify_rails_logger
    Rails.logger.error "#{self.class.name} - #{message}"
    Rails.logger.debug('   ' + backtrace.join("\n   ")) if backtrace.present?
  end

  def notify_support
    # ...
  end

  class << self
    def wrap(error, level: nil, context: nil)
      new(error.message, level: level, original_error: error, context: context)
    end
  end
end
```

For example, we use Twilio to send SMS. Working with Twilio we can get many different errors - user errors (e.g. incorrect phone number), account errors (e.g. insufficient funds), service errors (e.g. service is down), etc. We want to handle all of them and provide users with understandable feedback as well as notify our monitoring systems.

```ruby
class TwilioService
  def send_sms(phone_number, text)
    # call Twilio REST client
  rescue Twilio::REST::RestError, Twilio::REST::TwilioError => e
    raise TwilioService::Error.wrap(e)
  end
end

class TwilioService::Error < ApplicationError
  #
  def friendly_message
    I18n.t("code_#{code}", scope: 'twilio_service.errors', default: :default_message)
  end
end

# controller
begin
  TwilioService.send_sms(...)
rescue TwilioService::Error => e
  e.notify!
  redirect_back fallback_location: '/', notice: e.friendly_message
end
```

## Error Monitoring Services

- Sentry.io
- Airbrake.io
