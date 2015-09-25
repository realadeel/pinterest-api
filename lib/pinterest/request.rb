module Pinterest

  module Request

    def get(path, options={}, signature=false, raw=false, unformatted=false, no_response_wrapper=no_response_wrapper(), signed=sign_requests)
      request(:get, path, options, signature, raw, unformatted, no_response_wrapper, signed)
    end

    def post(path, options={}, signature=false, raw=false, unformatted=false, no_response_wrapper=no_response_wrapper(), signed=sign_requests)
      request(:post, path, options, signature, raw, unformatted, no_response_wrapper, signed)
    end

    def put(path, options={},  signature=false, raw=false, unformatted=false, no_response_wrapper=no_response_wrapper(), signed=sign_requests)
      request(:put, path, options, signature, raw, unformatted, no_response_wrapper, signed)
    end

    def delete(path, options={}, signature=false, raw=false, unformatted=false, no_response_wrapper=no_response_wrapper(), signed=sign_requests)
      request(:delete, path, options, signature, raw, unformatted, no_response_wrapper, signed)
    end

    private

    def request(method, path, options, signature=false, raw=false, unformatted=false, no_response_wrapper=false, signed=sign_requests)
      response = connection(raw).send(method) do |request|
        path = formatted_path(path) unless unformatted

        case method
        when :get, :delete
          request.url(URI.encode(path), options)
        when :post, :put
          request.path = URI.encode(path)
          request.body = options unless options.empty?
        end
      end
      return response if raw
      return response.body if no_response_wrapper
    end

    def formatted_path(path)
      [path, format].compact.join('.')
    end

  end
end
