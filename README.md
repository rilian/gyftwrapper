# Gyftwrapper

The Gyftwrapper provides Ruby APIs to purchase cards using the Gyft API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gyftwrapper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gyftwrapper

## Usage

Create a configuration file(`config/gyftwrapper.yml`):

```yaml
development: &default 
  api_key: your_key
  api_secret: your_secret
  endpoint: https://apitest.gyft.com/mashery/v1

test: 
  <<: *default

production:
  api_key: your_key
  api_secret: your_secret
  endpoint: https://api.gyft.com/mashery/v1
```

Purchase shop card

```ruby
Gyftwrapper.purchase_card(shop_card_id: 123, to_email: 'test@email.com')
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/gyftwrapper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
