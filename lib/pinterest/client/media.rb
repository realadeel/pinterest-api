module Pinterest
  class Client
    module Media
      class UploadFailed < StandardError; end

      DEFAULT_ASSET_TYPE = 'video'.freeze
      CONTENT_TYPE = 'application/json'.freeze

      DEFAULT_TIMEOUT_SECONDS = 300
      POLL_SLEEP_SECONDS = 5

      def upload(options = {})
        upload_id, upload_url, upload_parameters = register_upload(options)

        source_url = options.delete(:source_url)
        timeout = options.delete(:timeout) || DEFAULT_TIMEOUT_SECONDS
        media = open(source_url, 'rb')

        upload_resp = connection.send(:post) do |req|
          req.path = URI.encode(File.join(upload_url, ''))
          req.headers['Content-Type'] = "multipart/form-data"
          req.body = upload_parameters.merge({ file: Faraday::UploadIO.new(media, content_type(media))})
        end

        raise UploadFailed unless upload_resp.success?

        upload_id
      end

      private

      def register_upload(options = {})
        asset_type = options.delete(:asset_type) || DEFAULT_ASSET_TYPE

        response = post("media/uploads/register/", { type: asset_type}) do |req|
          req.headers["Content-Type"] = CONTENT_TYPE
          req.headers["Accept"] = CONTENT_TYPE
        end

        data = response.data
        upload_id = data.upload_id
        upload_url = data.upload_url
        upload_parameters = data.upload_parameters

        [upload_id, upload_url, upload_parameters]
      end

      def upload_filename(media)
        File.basename(media.base_uri.request_uri)
      end

      def extension(media)
        upload_filename(media).split('.').last
      end

      def content_type(media)
        ::MIME::Types.type_for(extension(media)).first&.content_type || get_content_type_from_file(media)
      end

      def get_content_type_from_file(media)
        `file --brief --mime-type - < #{Shellwords.shellescape(media.path)}`.strip
      end

      def poll_for_completion(asset_entity:)
        Timeout.timeout(DEFAULT_TIMEOUT_SECONDS, UploadTimeout) do
          loop do
            upload_status = upload_status(asset_entity: asset_entity).recipes[0].status

            case upload_status
            when "WAITING_UPLOAD"
              sleep POLL_SLEEP_SECONDS
            when "PROCESSING"
              sleep POLL_SLEEP_SECONDS
            when "INCOMPLETE"
              raise UploadIncomplete
            when "CLIENT_ERROR"
              raise UploadClientError
            when "AVAILABLE"
              break
            end
          end
        end
      end
    end
  end
end
