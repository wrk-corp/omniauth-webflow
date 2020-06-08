require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Webflow < OmniAuth::Strategies::OAuth2
      option :name, "webflow"
      # option :client_options, { site: "https://oauth.webflow.com" }
      option :client_options, {
        site: "https://api.webflow.com",
        authorize_url: 'https://webflow.com/oauth/authorize',
        token_url: 'https://api.webflow.com/oauth/access_token'
      }
      option :token_params, { parse: :json }
      option :auth_token_params, { mode: :query, param_name: :token }

      uid { raw_info['_id'] }

      info do
        {
          id: raw_info["_id",]
          grant_type: raw_info["grantType"],
          users: raw_info["users"],
        }
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('https://api.webflow.com/info').parsed["response"]
      end
    end
  end
end