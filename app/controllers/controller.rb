require_relative '../../infrastructure/s3'

class App < Sinatra::Base
  def s3_bucket
    Infrastructure::S3.bucket
  end

  post '/fetch-meals' do
    meals = fetch_meals

    respond_with({meals: meals})
  end

  private

  def fetch_meals
    s3_bucket.objects.map do |object|
      { 'url' => object.presigned_url(:get, expires_in: 3600) }
    end
  end

  def respond_with(data)
    status :ok
    content_type :json

    { data: data }.to_json
  end
end
