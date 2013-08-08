

module CompareRunsSpecHelper
    
    include DataHelper
    
    def perform_common_setup
    	@jan_1_2013 ="2013-01-01 00:00:00 UTC"
    	@jan_2_2013 ="2013-01-02 00:00:00 UTC"
    	@unit_tests = "UNIT TESTS"        
    end

    def create_new_project_and_subproject
        @project = create_project("COMPARE_RUNS_PROJECT")
        @sub_project = create_subproject_for_project(@project,"COMPARE_RUNS_SUBPROJECT")
    end

    def records_with_error_for(arg_sub_project,arg_test_category,arg_date)
    	extract_class_names_from(
            CompareRuns.get_test_suite_records_with_errors_for(arg_date,
										                        arg_sub_project.id,
										                        arg_test_category)
            )        
    end

    def create_class_errors(arg_suite,arg_hash_class_error)
		arg_hash_class_error.each_pair do |key , value|		  
			add_failed_tests_from_suite(arg_suite , key , value)
		end
    end
    
    def class_error_hash_from(*arg_prefixes)
    	result_hash = {}
    	arg_prefixes.each do |arg_prefix|
    		result_hash[create_class_name(arg_prefix)] = create_err_msg(arg_prefix) 
    	end
    	result_hash
    end

    def class_name_arr_from(*arg_prefixes)
        arg_prefixes.map{|prefix| create_class_name prefix}
    end

    def create_class_name(arg_prefix)
    	"class_#{arg_prefix}"
    end

    def create_err_msg(arg_prefix)
    	"error for class_#{arg_prefix}"
    end

    def form_data(arg_subproject,arg_test_category,arg_date1,arg_date2)
        {"sub_projects" => arg_subproject.id,
        "test_types" => arg_test_category,
        "date_one" => arg_date1,
        "date_two" => arg_date2}
    end

    def get_compare_result
       @compare_result=
       CompareRuns.getCompareResult form_data(@sub_project,@unit_tests,@jan_1_2013,@jan_2_2013)
    end

    def common_test_failures
        extract_class_names_from @compare_result[:common_failures]
    end

    def combined_test_failures
        extract_class_names_from @compare_result[:combined_total_failures]
    end

    def day_one_test_failures
        extract_class_names_from @compare_result[:test_case_records_for_date_one]
    end

    def day_two_test_failures
        extract_class_names_from @compare_result[:test_case_records_for_date_two]
    end

    def extract_class_names_from(arg_arr_test_case_records)
        return [] unless arg_arr_test_case_records
        arg_arr_test_case_records.map {|record| record.class_name}
    end

    def clean_up_data        
        delete_project_and_associated_records "COMPARE_RUNS_PROJECT"
    end

    

end