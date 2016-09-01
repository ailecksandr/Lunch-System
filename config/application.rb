require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JetRubyTest
  class Application < Rails::Application
    config.active_record.default_timezone = :local
    config.time_zone = 'Kyiv'
    config.autoload_paths += %W(#{config.root}/lib)
  end
end
