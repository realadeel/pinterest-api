require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Pinterest < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://api.pinterest.com/',
        :authorize_url => 'https://api.pinterest.com/oauth/',
        :token_url => 'https://api.pinterest.com/v1/oauth/token'
      }

      def request_phase
        options[:scope] ||= 'read_public,write_public'
        options[:response_type] ||= 'token'
        #options[:state] ||= '22'
        super
      end

      uid { raw_info['id'] }

      info { raw_info }

      def raw_info
        @raw_info ||= access_token.get('/v1/me/').parsed['data']
      end
    end
  end
end
