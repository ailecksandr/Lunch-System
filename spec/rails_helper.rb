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

  config.before { allow_any_instance_of(Paperclip::Attachment).to receive(:save).and_return(true) }

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
