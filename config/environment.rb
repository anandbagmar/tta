# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Tta::Application.initialize!
$PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), ".."))
puts "$PROJECT_ROOT = #{$PROJECT_ROOT}"
puts "Starting in environment: #{ENV["RAILS_ENV"]}"
