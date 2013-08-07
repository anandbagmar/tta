require 'spec_helper'
require 'rspec'

module CompareRunsHelper

	include DataHelper

	PROJECT ="PROJ_COMPARERUNS"
	SUBPROJECT = "SUB_PROJ_COMPARERUNS"
	JAN_1_2013 = "2013-01-01 00:00:00 UTC"
	JAN_2_2013 = "2013-01-02 00:00:00 UTC"

	def open_compare_runs_page
		visit '/compare_runs'
	end

	def select_project(arg_projectname)
		select arg_projectname , from:"project_select"
	end

	def create_test_data		
		@project = create_project(PROJECT)
		@subproject = create_subproject_for_project(@project , SUBPROJECT)
		@metadata1 = create_metadatum(@subproject,JAN_1_2013,"UNIT TESTS") 
		@test_suite1 = create_suite_with_metadata(@metadata1,"rest_unit_tests")
		add_failed_tests_from_suite @test_suite1 , "class_001" , "error_001"
	end

	def delete_project_and_associated_records(project_name)
		projects = Project.find_all_by_name(PROJECT)
		projects.each do |project|
			subprojects = SubProject.find_all_by_project_id project.id 
			delete_sub_projects subprojects 
			project.delete
		end
	end
	
end



describe "Compare Runs " , js:true do 
	
	self.use_transactional_fixtures = false

	include CompareRunsHelper
	

	before(:each) do
		create_test_data
	end	
end