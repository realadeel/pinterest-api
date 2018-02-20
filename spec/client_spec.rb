require 'spec_helper'

describe "Pinterest::Client" do

  before do
    @client = Pinterest::Client.new(ENV['ACCESS_TOKEN'])
  end

  describe 'next_page_uri' do
    it "should set next_page_path" do
      VCR.use_cassette("v1_client_next_page_path") do
        response = @client.get_followed_users

        expect(@client.next_page_uri).
          to eq("https://api.pinterest.com/v1/me/following/users/?access_token=<HIDDEN>&cursor=Pz8xMDAyMjcxNTYuNDQ5Xy0xfGQ4ODhhNjJjYjU5MTc2OGI1OGYxYTkwMjg2NTI2MmU1MjY4YTAxY2U4OWM1YWIyNWU3MDI4YWZmZDg5OWVjN2U%3D")
      end
    end
  end

  describe 'parse_next_path' do
    it 'todo' do
      expect(true).to eq(false)
    end
  end

  describe 'parse_next_options' do
    it 'todo' do
      expect(true).to eq(false)
    end
  end

end
