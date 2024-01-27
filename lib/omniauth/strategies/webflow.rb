require 'omniauth-oauth2'
require 'addressable/uri'

module OmniAuth
  module Strategies
    class Webflow < OmniAuth::Strategies::OAuth2
      API_VERSION = '1.0.0'.freeze

      option :name, 'webflow'
      option :client_options, {
        site: 'https://api.webflow.com',
        authorize_url: 'https://webflow.com/oauth/authorize',
        token_url: 'https://api.webflow.com/oauth/access_token'
      }

      uid { raw_info['_id'] }

      info do
        {
          id: raw_info['_id'],
          grant_type: raw_info['grantType'],
          users: raw_info['users'],
          orgs: raw_info['orgs'],
          sites: raw_info['sites']
        }
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get("https://api.webflow.com/info?api_version=#{API_VERSION}").parsed
      end
    end
  end
end
