class App < Sinatra::Base

  def initialize_s3_client
    Aws.config.update({
      region: 'us-east-1',
      credentials: Aws::Credentials.new(ENV['S3_ACCESS_KEY'], ENV['S3_SECRET_KEY']),
    })
  end

  def s3_bucket
    s3 = Aws::S3::Resource.new(region: ENV['S3_REGION'])
    s3.bucket(ENV['S3_BUCKET'])
  end

  post '/fetch-meals' do
    content_type :json
    initialize_s3_client

    meals = s3_bucket.objects.map { |o| { o.key => o.presigned_url(:get, expires_in: 3600) }}

    { data:
      {meals: meals
      }
    }.to_json
  end
end
