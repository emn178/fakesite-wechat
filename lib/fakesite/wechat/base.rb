module Fakesite
  module Wechat
    class Base < Fakesite::Base
      include WebMock::API

      def parameters
        now = Time.now.to_i.to_s
        {
          "code" => now,
          "state" => external_params["state"],
          "openid" => openid.to_s,
          "access_token" => "T#{now}",
          "refresh_token" => "R#{now}",
          "scope" => external_params["scope"],
          "nickname" => nickname,
          "sex" => sex,
          "province" => province,
          "city" => city,
          "country" => country,
          "headimgurl" => headimgurl
        }
      end

      def return_parameters
        openid = params["openid"]

        body = {}
        ["openid", "access_token", "refresh_token", "scope"].each do |key|
          body[key] = params[key]
          params.delete(key)
        end
        body["expires_in"] = 7200

        stub_request(:get, "https://#{ApiHost}/sns/oauth2/access_token")
          .with(:query => hash_including({:code => params["code"]}))
          .to_return(:status => 200, :body => body.to_json)

        body = {}
        ["nickname", "sex", "province", "city", "country", "headimgurl"].each do |key|
          body[key] = params[key]
          params.delete(key)
        end
        body["openid"] = openid

        stub_request(:get, "https://#{ApiHost}/sns/userinfo")
          .with(:query => hash_including({:openid => openid}))
          .to_return(:status => 200, :body => body.to_json)

        return params
      end

      def return_url
        external_params["redirect_uri"]
      end

      def self.match(external_uri)
        external_uri.host == Host
      end

      protected

      def get_value(obj, attr_name)
        !obj.nil? && obj.respond_to?(attr_name) ? obj.send(attr_name) : nil
      end

      def openid
        get_value(user, :id)
      end

      [:nickname, :sex, :province, :city, :country, :headimgurl].each do |key|
        name = key
        define_method(name) do
          attr_name = options[name] || name
          get_value(user, attr_name)
        end
      end
    end
  end
end
