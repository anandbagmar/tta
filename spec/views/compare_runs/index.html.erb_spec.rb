require 'spec_helper'
require 'rspec'
require File.expand_path("spec/helpers/comparesunsspechelper.rb")

module CompareRunsSeleniumHelper

	def open_compare_runs_page
		visit '/compare_runs'
	end

	def select_project(arg_projectname)
		select arg_projectname , from:"project_select"
	end

end

describe "Compare Runs " , js:true do 	
	
	self.use_transactional_fixtures = false	
	include CompareRunsSpecHelper
	include CompareRunsSeleniumHelper
	
	before(:each) do
		clean_up_data
		perform_common_setup
		create_new_project_and_subproject
	end

	after(:each){clean_up_data} 	

	it "shows the project on the page" do
		open_compare_runs_page
		sleep 10
	end
end