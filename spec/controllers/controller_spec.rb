require 'rack/test'
require 'spec_helper'
require './app/app.rb'

RSpec.describe 'app' do
  include Rack::Test::Methods

  def app
    App.new
  end

  describe 'POST fetch-meals' do
    it 'gives you a list of meals and links to a picture ' do
      s3_mock = Aws::S3::Resource.new(stub_responses: true)
      s3_mock.client.stub_responses(:list_buckets, {
        buckets: [{ name: 'mock-bucket' }]
      })
      s3_bucket_mock = s3_mock.bucket('mock-bucket')
      s3_object = Struct.new(:key, :presigned_url)

      meal = s3_object.new("test.jpg", "url")

      fake_meal_list = [meal]

      expect_any_instance_of(App).to receive(:s3_bucket).and_return(s3_bucket_mock)
      expect(s3_bucket_mock).to receive(:objects).and_return(fake_meal_list)

      post '/fetch-meals'

      expect(last_response.status).to eq(200)
      expect(last_parsed_response).to eq({
      "data" => {
        "meals" => [
          { "test.jpg" => "url" }
        ]
      }})
    end

    def last_parsed_response
      JSON.parse(last_response.body)
    end
  end
end
