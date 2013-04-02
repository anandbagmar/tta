require 'cucumber/rails'

Capybara.run_server = true
Capybara.default_selector = :css
Capybara.default_driver = :selenium

ActionController::Base.allow_rescue = false

#begin
#  DatabaseCleaner.strategy = :transaction
#rescue NameError
#  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
#end

if (ENV["HEADLESS"])
  puts "in headless"
  require 'headless'
  @headless = Headless.new(display: 100, reuse: true, :destroy_at_exit => false)
  @headless.start
end

at_exit do
  #this is creating problems while running parallel headless tests. find a better solution
  #@headless.destroy if ENV["HEADLESS"] && !@headless.nil?
end
#Cucumber::Rails::Database.javascript_strategy = :truncation

After do |scenario|
  if scenario.failed?
    file_name = SCREENSHOT_FILE_PATH+"screenshot_"+random_name+".png"
    save_error_screenshot(file_name)
  end
end
