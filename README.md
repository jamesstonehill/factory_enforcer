# FactoryEnforcer

[![Build Status](https://travis-ci.org/jamesstonehill/factory_enforcer.svg?branch=master)](https://travis-ci.org/jamesstonehill/factory_enforcer)

Worried that your lovely new factory class won't be used? Well, fear no more!
FactoryEnforcer takes care of this for you and ensures that your factor is used
when it should be.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'factory_enforcer'
```

And then execute:

    $ bundle

## Usage

```ruby
# app/models/user.rb

class User
  extend FactoryEnforcer
end

class UserFactory
  def self.build_user
    User.new
  end
end

# This will raise a FactoryEnforcer::FactoryNotUsed error!
user = User.new

# This will NOT raise an error.
user = UserFactory.build_user
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jamesstonehill/factory_enforcer.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
