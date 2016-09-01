module AmazonModule
  def s3_bucket
    s3 = Aws::S3::Client.new(region: ENV['AWS_REGION'])
    s3.buckets['jet-ruby-test']
  end

  def clear_s3_object(object)
    bucket = s3_bucket
    object = bucket.objects[object.path[1..-1]]
    object.delete
  end
end