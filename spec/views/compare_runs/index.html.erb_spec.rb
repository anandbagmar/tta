require 'spec_helper'
require 'rspec'
require File.expand_path("spec/helpers/comparesunsspechelper.rb")


class Fixnum

	def tests_failing
		"Number of failing tests: #{self}"
	end

end

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
	
	def table(id)
		find_by_id(id)
	end

	def classnames_listed_for_table(tablename)
		all(:xpath , "//table[@id='#{tablename}']/tbody/tr/td").map{|t| t.native.text}
	end

	def tests_failing_as(number_of_tests)
		"Number of failing tests: #{number_of_tests}"
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
	end

	after(:each){clean_up_data} 	

	context "when there are no failures" do 
		before do 
			open_compare_runs_page_and_perform_default_selection			
		end

		it "shows errors and error counts correctly" do
			table("result_table_common").should have_content(0.tests_failing)
			table("result_table_both").should have_content(0.tests_failing)
			table("result_table_date1").should have_content(0.tests_failing)
			table("result_table_date2").should have_content(0.tests_failing)			
			classnames_listed_for_table("result_table_common").should be_empty
			classnames_listed_for_table("result_table_both").should be_empty
			classnames_listed_for_table("result_table_date1").should be_empty
			classnames_listed_for_table("result_table_date2").should be_empty
		end
	end

	context "when there are failures only for day 1" do 

		before  do
			create_class_errors(@suite1,class_error_hash_from("001","002","003","004"))
			@expected_day_1_failures = class_name_arr_from "001","002","003","004"
			open_compare_runs_page_and_perform_default_selection
		end

		it "shows errors and error counts correctly" do
			sleep 30
		end

	end




end