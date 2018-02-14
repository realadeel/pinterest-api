require 'spec_helper'

describe "Pinterest::Client" do

  before do
    @client = Pinterest::Client.new(ENV['ACCESS_TOKEN'])
  end

  describe 'next_page_path' do
    it "should set next_page_path" do
      VCR.use_cassette("v1_client_next_page_path") do
        response = @client.get_followed_users

        expect(@client.next_page_path).
          to eq("me/following/users/?cursor=Pz8xMDAyMjcxNTYuNDQ5Xy0xfGQ4ODhhNjJjYjU5MTc2OGI1OGYxYTkwMjg2NTI2MmU1MjY4YTAxY2U4OWM1YWIyNWU3MDI4YWZmZDg5OWVjN2U%3D")
      end
    end
  end

  describe 'parse_next' do
    it 'should handle multiple query arguements' do
      next_uri = "https://api.pinterest.com/v1/me/following/users/?access_token=<HIDDEN>&cursor=Pz8xMDAyMjcxNTYuNDQ5Xy0xfGQ4ODhhNjJjYjU5MTc2OGI1OGYxYTkwMjg2NTI2MmU1MjY4YTAxY2U4OWM1YWIyNWU3MDI4YWZmZDg5OWVjN2U%3D&abc=123"

      expect(@client.send(:parse_next, next_uri)).
        to eq("me/following/users/?cursor=Pz8xMDAyMjcxNTYuNDQ5Xy0xfGQ4ODhhNjJjYjU5MTc2OGI1OGYxYTkwMjg2NTI2MmU1MjY4YTAxY2U4OWM1YWIyNWU3MDI4YWZmZDg5OWVjN2U%3D&abc=123")
    end
  end

end
