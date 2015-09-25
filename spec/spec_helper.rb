$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pinterest'

require 'vcr'
require 'webmock/rspec'
require 'dotenv'

Dotenv.load

TEST_API_KEY = "TPTESTCF24A7D8095EDF88E3EFD6103C"
RETURN_ADDRESS_ID = "555_Main_Street_Fake_City"

RSpec.configure do |config|
  # some (optional) config here
end

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/cassettes"
  c.hook_into :webmock
  c.default_cassette_options = { :record => :once }
end
