require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Pinterest < OmniAuth::Strategies::OAuth2
      option :client_options,
             site: 'https://api.pinterest.com/v3/',
             authorize_url: 'https://www.pinterest.com/oauth/',
             token_url: 'https://api.pinterest.com/v3/oauth/access_token/'

      uid { raw_info['id'] }

      info { raw_info }

      def request_phase
        options[:response_type] ||= 'code'
        options[:consumer_id] ||= options[:client_id]

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

      def build_access_token
        token = super

        if token.expires_at == 0
          ::OAuth2::AccessToken.new(token.client, token.token,
            token.params.reject{|k,_| [:refresh_token, :expires_in, :expires_at, :expires].include? k.to_sym}
          )
        else
          token
        end
      end

      def raw_info
        @raw_info ||=
          access_token.get("users/me/").parsed['data']
      end
    end
  end
end

# module OAuth2
#   # The OAuth2::Client class
#   class Client # rubocop:disable Metrics/ClassLength

#     # Initializes an AccessToken by making a request to the token endpoint
#     #
#     # @param [Hash] params a Hash of params for the token endpoint
#     # @param [Hash] access token options, to pass to the AccessToken object
#     # @param [Class] class of access token for easier subclassing OAuth2::AccessToken
#     # @return [AccessToken] the initialized AccessToken
#     def get_token(params, access_token_opts = {}, access_token_class = AccessToken) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
#       params = Authenticator.new(id, secret, options[:auth_scheme]).apply(params)
#       opts = {:raise_errors => options[:raise_errors], :parse => params.delete(:parse)}
#       headers = params.delete(:headers) || {}
#       if options[:token_method] == :post
#         opts[:body] = params
#         opts[:headers] = {'Content-Type' => 'application/x-www-form-urlencoded'}
#       else
#         opts[:params] = params
#         opts[:headers] = {}
#       end
#       opts[:headers].merge!(headers)
#       response = request(options[:token_method], token_url, opts)

#       if options[:raise_errors] && !(response.parsed.is_a?(Hash) && response.parsed['data']['access_token'])
#         error = Error.new(response)
#         raise(error)
#       end

#       access_token_class.from_hash(self, response.parsed['data'].merge(access_token_opts))
#     end
#   end
# end
