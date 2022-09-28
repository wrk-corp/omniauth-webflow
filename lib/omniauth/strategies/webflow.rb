require 'omniauth-oauth2'

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

      protected

      # callback_url includes the code parameter and Webflow decided to change their API recently
      # to require the redirect_uri to match exactly what you have in your Webflow Application settings.
      # This also means that you can not pass other url parameters through the redirect_uri.
      def build_access_token
        verifier = request.params['code']
        uri = Addressable::URI.parse(callback_url)
        redirect_uri = uri.omit(:query).to_s
        client.auth_code.get_token(verifier, { redirect_uri: redirect_uri }.merge(token_params.to_hash(symbolize_keys: true)), deep_symbolize(options.auth_token_params))
      end
    end
  end
end
