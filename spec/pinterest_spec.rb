require 'spec_helper'

describe Pinterest do
  it 'has a version number' do
    expect(Pinterest::VERSION).not_to be nil
  end

  describe Pinterest::Client do

    let(:client){Pinterest::Client.new(ENV['ACCESS_TOKEN'])}

    it 'should exist' do
      expect(client).to be_kind_of(Pinterest::Client)
    end

  end

end
