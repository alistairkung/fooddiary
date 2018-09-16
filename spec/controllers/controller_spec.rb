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
    configure_s3
    create_bucket
    upload_image
  end

  def configure_s3
    Infrastructure::S3.configure do |config|
      config.region = "us-east-1"
      config.access_key_id = "an_access_key_id"
      config.secret_access_key = "a_secret_access_key"
      config.endpoint = "http://s3:9000"
      config.bucket = "test"
    end
  end

  def create_bucket
    client = Infrastructure::S3.client
    s3 = Aws::S3::Resource.new(client: client)
    client.create_bucket({
      acl: "private",
      bucket: "test",
      create_bucket_configuration: {
        location_constraint: "us-east-1"
      }
    }) unless s3.bucket("test").exists?
  end

  def upload_image
    s3 = Aws::S3::Resource.new(client: Infrastructure::S3.client)
    obj = s3.bucket("test").object("soup.jpg")
    obj.upload_file("spec/fixtures/soup.jpg")
  end
end
