require 'capybara/rails'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'

Capybara.configure do |config|
  config.javascript_driver = :poltergeist
  config.current_driver = :poltergeist
  config.default_max_wait_time = 10
  config.run_server = true
end

Capybara.asset_host = 'http://localhost:3000'
Capybara.save_path = 'spec/screenshots'
