require 'aws-sdk'

Aws.config.update(
  endpoint: 'http://localhost:9000',
  access_key_id: ENV['S3_ACCESS_KEY'],
  secret_access_key: ENV['S3_SECRET_KEY'],
  force_path_style: true,
  region: 'us-east-1'
)

s3_client = Aws::S3::Client.new
