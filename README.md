# fakesite-wechat

[![Build Status](https://api.travis-ci.org/emn178/fakesite-wechat.png)](https://travis-ci.org/emn178/fakesite-wechat)
[![Coverage Status](https://coveralls.io/repos/emn178/fakesite-wechat/badge.svg?branch=master)](https://coveralls.io/r/emn178/fakesite-wechat?branch=master)

A [fakesite](https://github.com/emn178/fakesite) plugin that provides a stub method for wechat. It's useful to bypass oauth flow in develpment environment.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fakesite-wechat', group: :development
```

And then execute:

    $ bundle

### Route
Make sure that you have added fakesite route in your `config/route.rb`
```Ruby
mount Fakesite::Engine => "/fakesite" if Rails.env.development?
```

## Usage
Add registration to `config/initializers/fakesite.rb`
```Ruby
if Rails.env.development?
  WebMock.allow_net_connect!
  # fill data from devise current_user, you can change this to get correct data automatically
  options = {
  #   :nickname => :nickname,
  #   :sex => :sex, 
  #   :province => :province, 
  #   :city => :city, 
  #   :country => :country, 
  #   :headimgurl => :headimgurl
  }
  Fakesite.register :wechat, Fakesite::Wechat::Base, options
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Contact
The project's website is located at https://github.com/emn178/fakesite-wechat  
Author: emn178@gmail.com
