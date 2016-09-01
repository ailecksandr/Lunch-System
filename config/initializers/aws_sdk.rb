require 'aws-sdk'

Aws.config.update({
    credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
    region: ENV['AWS_REGION']
})