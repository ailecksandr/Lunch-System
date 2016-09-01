module AmazonModule
  def s3_bucket
    s3 = AWS::S3::Client.new(access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
    s3.buckets['jet-ruby-test']
  end

  def clear_s3_object(object)
    bucket = s3_bucket
    object = bucket.objects[object.path[1..-1]]
    object.delete
  end
end