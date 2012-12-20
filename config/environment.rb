# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Tta::Application.initialize!

# ROOT FOLDER
$PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), ".."))
puts "$PROJECT_ROOT = #{$PROJECT_ROOT}"

