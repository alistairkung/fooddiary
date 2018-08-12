require 'rack/test'
require 'spec_helper'
require './app/app.rb'

RSpec.describe 'app' do
  include Rack::Test::Methods

  def app
    App.new
  end

  describe 'POST fetch-meals' do
    it 'returns 200' do
      post '/fetch-meals'

      expect(last_response.status).to eq(200)
      expect(last_parsed_response).to eq({
      "data" => {
        "meals" => [
          "wax_gourd_pork_rib_soup-cropped.jpg"
        ]
      }})
    end

    def last_parsed_response
      JSON.parse(last_response.body)
    end
  end
end
