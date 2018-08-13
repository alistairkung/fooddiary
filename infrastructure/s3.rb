module Infrastructure
  class S3
    class << self
      def bucket
        s3 = Aws::S3::Resource.new(client: client)
        s3.bucket(ENV['S3_BUCKET'])
      end

      private

      def client
        @client ||= instance_client
      end

      def instance_client
        Aws::S3::Client.new({
          region: ENV['S3_REGION'],
          access_key_id: ENV['S3_ACCESS_KEY'],
          secret_access_key: ENV['S3_SECRET_KEY'],
          endpoint: ENV['S3_ENDPOINT'],
          force_path_style: true
        })
      end
    end
  end
end
