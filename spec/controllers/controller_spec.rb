require 'rack/test'
require 'spec_helper'
require './app/app.rb'
require_relative '../../infrastructure/s3'

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
      expect(the_meal['url']).to include('soup.jpg')
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
    client = Infrastructure::S3.client
    s3 = Aws::S3::Resource.new(client: client)
    client.create_bucket({
      acl: "private",
      bucket: ENV['S3_BUCKET'],
      create_bucket_configuration: {
        location_constraint: ENV['S3_REGION']
      }
    }) unless s3.bucket(ENV['S3_BUCKET']).exists?
  end

  def upload_image
    s3 = Aws::S3::Resource.new(client: Infrastructure::S3.client)
    obj = s3.bucket(ENV['S3_BUCKET']).object('soup.jpg')
    obj.upload_file('spec/fixtures/soup.jpg')
  end
end
