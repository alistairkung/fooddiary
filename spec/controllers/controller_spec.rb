require 'rack/test'
require 'spec_helper'
require './app/app.rb'

RSpec.describe 'app' do
  include Rack::Test::Methods

  def app
    App.new
  end

  before do
    setup_s3
  end

  describe 'POST fetch-meals' do
    it 'provides a list of meals' do
      post '/fetch-meals'

      the_meal = last_parsed_response['data']['meals'].first
      expect(the_meal['url']).to include('avatar.png')
    end

    def last_parsed_response
      JSON.parse(last_response.body)
    end
  end

  def setup_s3
    create_bucket
    upload_image
  end

  def create_bucket

  end

  def upload_image
    
  end
end
