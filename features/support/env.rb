require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'rspec'
require 'selenium-webdriver'


require 'test/unit/assertions'
World(Test::Unit::Assertions)

Capybara.run_server = false
Capybara.default_driver = :selenium
Capybara.default_selector = :css

module Helpers
  def without_resynchronize
    page.driver.options[:resynchronize] = false
    yield
    page.driver.options[:resynchronize] = true
  end
end
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end
#Selenium::WebDriver::Firefox::Binary.path='/Applications/Firefox 3.6.app/Contents/MacOS/firefox-bin'
def firefox
  ffprofile = Selenium::WebDriver::Firefox::Profile.new
  Capybara::Selenium::Driver::DEFAULT_OPTIONS[:profile] = ffprofile
end

World(Capybara::DSL, Helpers)