require 'faraday_middleware'
require 'pinterest/client/user'
require 'pinterest/client/pin'
require 'pinterest/client/board'

module Pinterest
  class Client

    include Pinterest::Client::User
    include Pinterest::Client::Pin
    include Pinterest::Client::Board

    BASE_ENDPOINT = 'https://api.pinterest.com/v1/'.freeze
    DEFAULT_USER_AGENT = "Pinterest Ruby Gem #{Pinterest::VERSION}".freeze
    DEFAULT_ADAPTER = Faraday.default_adapter

    def initialize(access_token = nil, connection_options={})
      @access_token = access_token
      @connection_options = connection_options
    end

    attr_reader :access_token

    def get(path, options={})
      request(:get, path, options)
    end

    def post(path, options={})
      request(:post, path, options)
    end

    def patch(path, options={})
      request(:patch, path, options)
    end

    def put(path, options={})
      request(:put, path, options)
    end

    def delete(path, options={})
      request(:delete, path, options)
    end

    private

    def request(method, path, options)
      raw = options.delete(:raw)
      log = options.delete(:log)
      path = File.join(path, '')
      response = connection(raw, log).send(method) do |request|
        case method
        when :get
          path = path + "?access_token=" + @access_token
          request.url(URI.encode(path), options)
        when :patch
          request.path = path + "?access_token=" + @access_token
          request.body = options unless options.empty?
          request.headers['Authorization'] = "BEARER #{@access_token}"
        when :post, :put, :delete
          request.path = URI.encode(path)
          request.body = options unless options.empty?
          request.headers['Authorization'] = "BEARER #{@access_token}"
        end
      end
      return response.body
    end

    def connection(raw = false, log = false)
      options = @connection_options.merge({
        :headers => {'Accept' => "application/json; charset=utf-8", 'User-Agent' => user_agent},
        :url => endpoint,
      })

      Faraday::Connection.new(options) do |connection|
        unless raw
          connection.use FaradayMiddleware::Mashify
        end
        connection.use Faraday::Request::Multipart
        connection.use Faraday::Response::ParseJson
        connection.use Faraday::Request::UrlEncoded
        connection.response :logger if log
        connection.adapter(adapter)
      end
    end

    def endpoint
      BASE_ENDPOINT
    end

    def user_agent
      DEFAULT_USER_AGENT
    end

    def adapter
      DEFAULT_ADAPTER
    end

  end
end
