require 'spec_helper'

describe "Pinterest::Client::Board" do

  before do
    @client = Pinterest::Client.new(ENV['ACCESS_TOKEN'])
  end

  describe 'POST /v1/boards/' do
    # create_board
    context "have the parameters for a board" do
      it "should create a board" do
        VCR.use_cassette("v1_create_board") do
          response = @client.post('boards/', {
            name: 'Test',
            description: 'Test from Ruby gem',
          })
          expect(response.data.id).to be
          expect(response.data.url).to be
          expect(response.data.name).to eq('Test')
        end
      end
    end
    context "missing name of a board" do
      it "should response with an error message" do
        VCR.use_cassette("v1_not_create_board") do
          response = @client.post('boards/', {
            description: 'Test from Ruby gem',
          })
          expect(response.message).to be
        end
      end
    end
  end

  describe 'GET /v1/boards/<board_id>/' do
    # get_board(id)
    context "the board exists" do
      it "should get the board" do
        VCR.use_cassette("v1_board") do
          response = @client.get('boards/154177987217226202/')
          expect(response.data.keys).to match_array(['id', 'link', 'note', 'url'])
        end
      end
    end
    context "the board does not exist" do
      it "should respond with an error" do
        VCR.use_cassette("v1_no_board") do
          response = @client.get('boards/123/')
          expect(response.message).to be
        end
      end
    end
  end

  describe 'DELETE /v1/boards/<board_id>/' do
    # delete_board
    context "the board exists" do
      it "should delete a board" do
        VCR.use_cassette("v1_delete_board") do
          response = @client.delete('boards/154178055932401495/')
          expect(response).to have_key(:data)
          expect(response.data).to be_falsey
          # TODO use response code
          # will need to spit it out from response
          # not finding a board will have data: null
          # just like successfully deleting a board
          # only difference is 404
        end
      end
    end
    context "the board does not exist" do
      it "should response with an error message" do
        VCR.use_cassette("v1_not_delete_board") do
          response = @client.delete('boards/1/')
          expect(response.message).to be
        end
      end
    end
  end

end
