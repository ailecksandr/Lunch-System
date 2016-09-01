module AmazonModule
  def clear_s3_object(object)
    s3 = Aws::S3::Client.new(region: ENV['AWS_REGION'])
    s3.delete_object({
      bucket: ENV['S3_BUCKET_NAME'],
      key: object.path[1..-1]
    })
  end
end