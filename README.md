# omniauth-webflow

This gem is an [OmniAuth](https://github.com/omniauth/omniauth) Strategy for authenticating with the [Webflow API](https://developers.webflow.com/)

## Setup

First, you will need to register your application with Webflow. This can be done on the [Integrations](https://webflow.com/dashboard/account/integrations) tab.

**Important:** your callback URL should be specified as `https://[hostname]/auth/webflow/callback`

In order to authenticate with Webflow in both development and production we recommend registering a "-dev" app with Webflow that points at your localhost app. One thing to note here is that Webflow requires your callback url to be `https`.

After registering a new application with Webflow take note of the `client_id` and `client_secret` provided. You should put these into your Rails credentials or store them as environment variables like `ENV['WEBFLOW_CLIENT_ID']` and `ENV['WEBFLOW_CLIENT_SECRET']`

## Usage

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-webflow', '~> 1.0.0'
```

And then execute:

    $ bundle install

In your Rails app, add the Webflow provider to your Omniauth middleware, e.g. in a file like `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :webflow, ENV['WEBFLOW_CLIENT_ID'], ENV['WEBFLOW_CLIENT_SECRET'],
  scope: 'authorized_user:read' # the scope is an example and not required
end
```

Specify [scopes](https://docs.developers.webflow.com/reference/scopes) as required.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wrk-corp/omniauth-webflow. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/wrk-corp/omniauth-webflow/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Omniauth::Webflow project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/wrk-corp/omniauth-webflow/blob/master/CODE_OF_CONDUCT.md).
