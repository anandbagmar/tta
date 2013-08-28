

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

end
