require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Webflow < OmniAuth::Strategies::OAuth2
      API_VERSION = "1.0.0"

      option :name, "webflow"
      option :client_options, {
        site: "https://api.webflow.com",
        authorize_url: 'https://webflow.com/oauth/authorize',
        token_url: 'https://api.webflow.com/oauth/access_token'
      }
      # option :token_params, { parse: :json }
      # option :auth_token_params, { mode: :query, param_name: :token }

      uid { raw_info['_id'] }

      info do
        {
          id: raw_info["_id"],
          grant_type: raw_info["grantType"],
          users: raw_info["users"],
          orgs: raw_info["orgs"],
          sites: raw_info["sites"],
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

      # had to override this method as it was merging the redirect_uri into the params which was breaking the Webflow /access_token request
      def build_access_token
        verifier = request.params["code"]
        client.auth_code.get_token(verifier, token_params.to_hash(:symbolize_keys => true), deep_symbolize(options.auth_token_params))
      end

    end
  end
end