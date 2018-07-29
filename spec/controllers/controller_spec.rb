require 'rack/test'
require 'spec_helper'
require './app/app.rb'

RSpec.describe 'app' do
  include Rack::Test::Methods

  def app
    App.new
  end

  describe 'GET root' do
    it 'returns 200' do
      get '/'

      expect(last_response.status).to eq(200)
    end

    def last_parsed_response
      JSON.parse(last_response.body)
    end
  end
end
