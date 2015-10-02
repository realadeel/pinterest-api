require 'spec_helper'

describe "Pinterest::Omniauth" do
  context 'client options' do
    before :each do
      @auth = Pinterest::Omniauth.new({})
    end

    it 'should call correct base url' do
      expect(@auth.options.client_options.site).to eq('https://api.pinterest.com/')
    end

    it 'should call correct authorization url' do
      expect(@auth.options.client_options.authorize_url).to eq('https://api.pinterest.com/oauth/')
    end

    it 'should call correct token url' do
      expect(@auth.options.client_options.token_url).to eq('https://api.pinterest.com/v1/oauth/token')
    end
  end
end
