require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Webflow < OmniAuth::Strategies::OAuth2
      option :name, 'webflow'
      option :client_options, {
        site: 'https://api.webflow.com',
        authorize_url: 'https://webflow.com/oauth/authorize',
        token_url: 'https://api.webflow.com/oauth/access_token'
      }

      uid { raw_info['authorization']['id'] }

      info do
        raw_info['authorization']
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/v2/token/introspect").parsed
      end

      def token_params
        super.merge({
          client_id: options.client_id,
          client_secret: options.client_secret,
        })
      end

      def callback_url
        full_host + callback_path
      end
    end
  end
end
