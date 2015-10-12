# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fakesite/wechat/version'

Gem::Specification.new do |spec|
  spec.name          = "fakesite-wechat"
  spec.version       = Fakesite::Wechat::VERSION
  spec.authors       = ["Chen Yi-Cyuan"]
  spec.email         = ["emn178@gmail.com"]

  spec.summary       = %q{A fakesite plugin that provides a stub method for wechat.}
  spec.description   = %q{A fakesite plugin that provides a stub method for wechat.}
  spec.homepage      = "https://github.com/emn178/fakesite-wechat"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "fakesite", ">= 0.2.3"
  spec.add_dependency "webmock"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
end
