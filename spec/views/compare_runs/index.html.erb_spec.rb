require 'spec_helper'
require 'rspec'
require File.expand_path("spec/helpers/comparesunsspechelper.rb")

module CompareRunsSeleniumHelper

	def open_compare_runs_page
		visit '/compare_runs'
		page.driver.browser.manage.window.maximize
	end

	def select_by_value(id, value)
  		option_xpath = "//*[@id='#{id}']/option[@value='#{value}']"
  		option = find(:xpath, option_xpath).text
  		select(option, :from => id)
	end

	def perform_default_selections
		select "COMPARE_RUNS_PROJECT" , from: "project_select"
		select "COMPARE_RUNS_SUBPROJECT" , from: "sub_project_select"
		select @unit_tests , from:"test_types_select"
		select_by_value  "date_one_select" , @jan_1_2013.sub("UTC","") 
		select_by_value  "date_two_select" , @jan_2_2013.sub("UTC","")
		find_by_id("compare_runs").click
	end

	def open_compare_runs_page_and_perform_default_selection
		open_compare_runs_page
		perform_default_selections
	end
end

#open CompareRunsSpecHelper and add some common methods
module CompareRunsSpecHelper
	
	# include DataHelper	

	def create_test_suites
		@metadata1 = create_metadatum(@sub_project , @jan_1_2013 , @unit_tests)
		@metadata2 = create_metadatum(@sub_project , @jan_2_2013 , @unit_tests)
		@suite1 = create_suite_with_metadata(@metadata1 , "suite001")
		@suite2 = create_suite_with_metadata(@metadata2 , "suite002")
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
		create_test_suites
		open_compare_runs_page
		perform_default_selections
	end

	after(:each){clean_up_data} 	

	it "shows the project on the page" do		
		sleep 30
	end
end