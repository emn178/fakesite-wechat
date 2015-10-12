require 'json'
require "webmock"
require "fakesite"
require "fakesite/wechat/version"
require "fakesite/wechat/base"

module Fakesite
  module Wechat
    Host = "open.weixin.qq.com"
    ApiHost = "api.weixin.qq.com"
  end
end
