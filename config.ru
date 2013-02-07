# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
TESTTYPE = YAML.load(File.open("#{Rails.root}/config/test_types.yml","r"))
run Tta::Application

