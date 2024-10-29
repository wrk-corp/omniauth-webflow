# frozen_string_literal: true

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
        {
          id: raw_info['authorization']['id'],
          grant_type: raw_info['authorization']['grantType']
        }
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('https://api.webflow.com/v2/token/introspect').parsed
      end

      # The Webflow API requires the redirect_uri to match exactly what you have in your Webflow Application settings
      # This method ensures any query params are removed before the build_access_token step occurs
      def callback_url
        full_host + callback_path
      end
    end
  end
end
