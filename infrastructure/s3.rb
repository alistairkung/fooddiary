require_relative '../config/configurable'

module Infrastructure
  class S3
    include Configurable

    configure_with :region, :access_key_id, :secret_access_key, :endpoint, :bucket

    class << self
      def client
        @client ||= instance_client
      end

      def bucket
        s3 = Aws::S3::Resource.new(client: client)
        s3.bucket(configuration.bucket)
      end

      private

      def instance_client
        Aws::S3::Client.new({
          region: configuration.region,
          access_key_id: configuration.access_key_id,
          secret_access_key: configuration.secret_access_key,
          endpoint: configuration.endpoint,
          force_path_style: true
        })
      end
    end
  end
end
