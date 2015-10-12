require 'simplecov'
require 'coveralls'

SimpleCov.add_filter "/spec/"

if ENV["COVERAGE"]
  SimpleCov.start
elsif ENV["COVERALLS"]
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  Coveralls.wear!
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ostruct'
require 'fakesite/wechat'
require 'rspec/its'
require 'net/http'
