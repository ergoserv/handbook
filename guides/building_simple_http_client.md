# Building a simple HTTP Client

## Introduction

A very simple and handy HTTP Client can be build with [httparty](https://github.com/jnunemaker/httparty).

## Conventions

* Class should be named according to the service name it interacts with (e.g.: `TwitterClient`)
* Class should have suffix `Client` (e.g.: `TwitterClient`).
* Class should be stored inside the corresponding [service module](service_modules.md) directory (e.g.: `app/services/twitter_service/twitter_client.rb`).

## Examples

### TwitterClient

```ruby
# app/services/twitter_service/twitter_client.rb
module TwitterService
  class TwitterClient
    include HTTParty
    
    base_uri 'twitter.com'

    def initialize(username, password)
      @auth = {username: username, password: password}
    end

    # which can be :friends, :user or :public
    # options[:query] can be things like since, since_id, count, etc.
    def timeline(which = :friends, options = {})
      options.merge!({ basic_auth: @auth })
      self.class.get("/statuses/#{which}_timeline.json", options)
    end

    def post(text)
      options = { query: { status: text }, basic_auth: @auth }
      self.class.post('/statuses/update.json', options)
    end
  end
end

# app/services/twitter_service.rb
module TwitterService
  module_function

  def client
    @client ||=TwitterService::TwitterClient.new(secret_twitter_email, secret_twitter_password)
  end
end
```

```ruby
## usage

# custom twitter client
twitter_client = TwitterService::TwitterClient.new('test@mail.com', 'password')
twitter_client.timeline

# singleton twitter client
TwitterService.client.timeline
```

## References

* [httparty](https://github.com/jnunemaker/httparty)
* [Service Modules](../guides/service_modules.md)
