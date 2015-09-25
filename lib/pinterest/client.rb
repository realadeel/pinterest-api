require 'pinterest/connection'
require 'pinterest/request'
require 'pinterest/client/user'
require 'pinterest/client/pin'
require 'pinterest/client/board'

module Pinterest
  class Client

    def initialize(access_token = nil)
      @access_token = access_token
    end

    attr_reader :access_token

    include Connection
    include Request
  end
end
