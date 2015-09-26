$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pinterest'

require 'vcr'
require 'webmock/rspec'
require 'dotenv'

Dotenv.load

RSpec.configure do |config|
  # some (optional) config here
end

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/cassettes"
  c.hook_into :webmock
  c.default_cassette_options = { record: :once }
end
