# SRack

Hacky serverless function Rack handler to enable Sinatra apps in AWS Lambda.

Based on [aws-samples/serverless-sinatra-sample](https://github.com/aws-samples/serverless-sinatra-sample)

## Installation

Add the following line to your `Gemfile`:

```ruby
gem "srack"
```

Or just `gem install srack`.


## Usage

Define your AWS Lambda function handler as the following:

```ruby
require 'srack'

RACK_APP_CONFIG = "#{__dir__}/app/config.ru"

# Global object that responds to the call method. Stay outside of the handler
# to take advantage of container reuse
$app ||= Rack::Builder.parse_file(RACK_APP_CONFIG)
ENV['RACK_ENV'] ||= 'production'

def handler(event:, context:)
  SRack::AWSLambdaHandler
    .new($app)
    .handle(event:   event,
            context: context)
end
```

Then create a deployment zip with your AWS Lambda function and its dependencies.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nomadium/srack. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/nomadium/srack/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SRack project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/nomadium/srack/blob/master/CODE_OF_CONDUCT.md).
