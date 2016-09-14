require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module JetRubyTest
  class Application < Rails::Application
    config.time_zone = 'Kyiv'
    config.active_record.default_timezone = :local
  end
end
