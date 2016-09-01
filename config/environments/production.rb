Rails.application.configure do

  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.action_mailer.default_url_options = { host: 'http://jet-ruby-test.herokuapp.com/' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default :charset => 'utf-8'

  config.action_mailer.smtp_settings = {
      address:        'smtp.sendgrid.net',
      domain:         'heroku.com',
      port:           587,
      user_name:      ENV['SENDGRID_USERNAME'],
      password:       ENV['SENDGRID_PASSWORD'],
      authentication: 'plain',
      enable_starttls_auto: true
  }

  config.paperclip_defaults = {
      storage: :s3,
      s3_region: ENV['AWS_S3_REGION'],
      s3_credentials: {
          bucket: ENV['S3_BUCKET_NAME'],
          access_key_id: ENV['AWS_ACCESS_KEY_ID'],
          secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
      }
  }

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.serve_static_assets = true

  config.assets.compile = true
  config.assets.digest = true

  config.log_level = :debug

  config.log_tags = [ :request_id ]

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
end
