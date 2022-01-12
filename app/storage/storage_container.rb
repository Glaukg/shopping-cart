class StorageContainer
  include Concurrent::Async

  def initialize
    @bucket_name = ENV['S3_BUCKET']
    @region = ENV['S3_REGION']
    @s3_client = Aws::S3::Client.new(region: @region)
  end

  def object_uploaded?(file_name, file_data)
    response = @s3_client.put_object(
      bucket: @bucket_name,
      key: file_name,
      body: file_data
    )
    if response.etag
      return true
    else
      return false
    end
  rescue StandardError => e
    puts "Error uploading object: #{e.message}"
    return false
  end
end
