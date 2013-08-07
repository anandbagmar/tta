

class Symbol 
 	def as  value 
 		hash = {}
 		hash[self] = value
 		hash
	end
end

module DataHelper

	def create(*args)
		FactoryGirl.create(*args)
	end

	def with(*args)
 		result_hash = {}
 		args.each do|hash| 			
 			hash.each_key do |key| 			
 				result_hash[key] = hash[key]
 			end
 		end
 		result_hash 
	end
 	
	def create_project(arg_name="TEST_PROJECT") 		
		create :project ,
		with(
				:name.as(arg_name)
			) 		
	end

	def create_subproject_for_project(arg_project,arg_name="TESTS_SUBPROJECT") 		
 		create :sub_project , 
 		with(
 				:name.as(arg_name) , 
 				:project_id.as(arg_project.id)
 			) 
	end

	def create_metadatum(arg_sub_project, arg_date , arg_test_category="INTEGRATION TESTS")   
		create :test_metadatum , 
		with(
				:sub_project_id.as(arg_sub_project.id) , 
				:date_of_execution.as(arg_date) , 
				:test_category.as(arg_test_category)
			)
	end

	def create_suite_with_metadata(arg_metadata , arg_class_name="Class001")
		create :test_suite_records , 
		with(
				:test_metadatum_id.as(arg_metadata.id) ,
				:class_name.as(arg_class_name)
			)
	end	

	def add_failed_tests_from_suite(arg_suite , arg_class_name="Class001_1" , arg_err_msg="error001_1")
		create :test_case_record ,
		with(
				:test_suite_record_id.as(arg_suite.id) ,
				:class_name.as(arg_class_name),
				:error_msg.as(arg_err_msg)
			)
	end

	def get_metadata(arg_sub_project , arg_test_category , arg_date)
		TestMetadatum.get_record_for_specific_date(
			arg_sub_project.id,
			arg_test_category,
			arg_date)
	end

	def delete_project_and_associated_records(project_name)
		projects = Project.find_all_by_name(PROJECT)
		projects.each do |project|
			subprojects = SubProject.find_all_by_project_id project.id 
			delete_sub_projects_and_associated_records subprojects 
			project.delete
		end
	end

		def delete_sub_projects_and_associated_records(subprojects)
		subprojects.each do |subproject|
			metadata = TestMetadatum.find_all_by_sub_project_id subproject.id 
			delete_metadata_and_associated_records	metadata
			subproject.delete		
		end
	end

	def delete_metadata_and_associated_records(test_metadata)
		test_metadata.each do |test_metadatum|
			test_suites = TestSuiteRecord.find_all_by_test_metadatum_id test_metadatum.id
			delete_test_suites_and_associated_records test_suites
			test_metadatum.delete
		end		
	end

	def delete_test_suites_and_associated_records(test_suites)
		test_suites.each do |test_suite|
			test_case_records = TestCaseRecord.find_all_by_test_suite_record_id test_suite.id
			delete_test_case_records test_case_records
			test_suite.delete
		end
	end

	def delete_test_case_records(test_case_records)
		test_case_records.each do |test_case_record|
			test_case_record.delete
		end
	end
end
