ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
SimpleCov.start 'rails'

require File.expand_path('../../config/environment', __FILE__)

require 'faker'
require 'support/factory_girl'
require 'paperclip/matchers'

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'

require 'capybara/rails'
require 'capybara/rspec'

Capybara.configure do |config|
  config.javascript_driver = :webkit
  config.current_driver = :webkit
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Paperclip::Shoulda::Matchers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Warden::Test::Helpers
  config.include WorkingDayseable

  config.before do
    allow_any_instance_of(Paperclip::Attachment).to receive(:save).and_return(true)
    allow_any_instance_of(AmazonModule).to receive(:clear_s3_object).and_return(nil)
  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
