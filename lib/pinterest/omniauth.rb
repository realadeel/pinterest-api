require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Pinterest < OmniAuth::Strategies::OAuth2
      option :client_options,
             site: 'https://www.pinterest.com/',
             authorize_url: 'https://www.pinterest.com/oauth/',
             token_url: 'https://api.pinterest.com/v3/oauth/access_token/'

      uid { raw_info['id'] }

      info { raw_info }

      def request_phase
        options[:scope] ||= 'read_public'
        options[:response_type] ||= 'code'
        super
      end

      def authorize_params
        super.tap do |params|
          %w[redirect_uri].each do |v|
            params[:redirect_uri] = request.params[v] if request.params[v]
          end
        end
      end

      def ssl?
        true
      end

      def raw_info
        fields = 'first_name,id,last_name,url,account_type,username,bio,image'
        @raw_info ||=
          access_token.get("/v1/me/?fields=#{fields}").parsed['data']
      end
    end
  end
end
