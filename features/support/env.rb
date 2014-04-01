require 'rspec/expectations'
require 'cucumber/rails'
require 'selenium-webdriver'
require_relative 'file_utils.rb'

# Set the RAILS_ENV
$RAILS_ENV = ENV['RAILS_ENV']  ||= "development"
puts "RAILS_ENV: #{$RAILS_ENV}"

# Add the drivers to the path
ENV['PATH']+= File::PATH_SEPARATOR + absolute_path("#{$PROJECT_ROOT}","lib","drivers") + File::PATH_SEPARATOR
puts "Updated PATH = #{ENV['PATH']}"

Capybara.run_server = true
Capybara.default_selector = :css
Capybara.register_driver :firefox do |app|
  puts "NOTE: Max Firefox version supported = 25.0 (on Mac)"
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

Capybara.javascript_driver = :firefox
Cucumber::Rails::Database.autorun_database_cleaner = false
Cucumber::Rails::Database.javascript_strategy = :transaction

ActionController::Base.allow_rescue = true

if (ENV["HEADLESS"])
  puts "in headless"
  require 'headless'
  @headless = Headless.new(display: 100, reuse: true, :destroy_at_exit => true)
  @headless.start
end

at_exit do
  puts "*** at_exit hook"
  #this is creating problems while running parallel headless tests. find a better solution
  #@headless.destroy if ENV["HEADLESS"] && !@headless.nil?
end

Before do
  puts "**** Starting new scenario execution"
end

After do |scenario|
  #puts "**** Scenario: #{scenario.scenario}"
  if scenario.failed?
    file_name = SCREENSHOT_FILE_PATH+"screenshot_"+random_name+".png"
    save_error_screenshot(file_name)
  end
end
