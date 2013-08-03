require "rspec"

RSpec::Matchers.define :contain_all do |expected|
	match do |actual|
		(actual.length == expected.length ) and (actual.to_set == expected.to_set)
	end
end

module CompareRunsSpecHelper
    
    include DataHelper
    
    def common_setup
    	@jan_1_2013 ="2013-01-01 00:00:00 UTC"
    	@jan_2_2013 ="2013-01-02 00:00:00 UTC"
    	@unit_tests = "UNIT TESTS"
    end

    def create_new_project_and_subproject
        @project = create_project("COMPARE_RUNS")
        @sub_project = create_subproject_for_project(@project,"COMPARE_RUNS_SUBPROJECT")
    end

    def records_with_error_for(arg_sub_project,arg_test_category,arg_date)
    	records = CompareRuns.get_test_suite_records_with_errors_for(arg_date,
    												arg_sub_project.id,
    												arg_test_category)
    	result = []
    	records.each {|record| result << record.class_name}
    	result
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
    	result_arr=[]
    	arg_prefixes.each {|prefix| result_arr << create_class_name(prefix)}
    	result_arr
    end

    def create_class_name(arg_prefix)
    	"class_#{arg_prefix}"
    end

    def create_err_msg(arg_prefix)
    	"error for class_#{arg_prefix}"
    end

end


describe "CompareRuns" do 

	include CompareRunsSpecHelper
	
	before(:each) do		
		common_setup
		create_new_project_and_subproject
		@metadata1 = create_metadatum(@sub_project,@jan_1_2013,@unit_tests)	
		@test_suite1 = create_suite_with_metadata(@metadata1,"rest_unit_tests")		
	end

	describe "#get_test_suite_records_with_errors_for" do 

		context "when there are no failures for a subproject and test category on a given day" do
        	it "should return no records" do
        		records_with_error_for(@sub_project,@unit_tests,@jan_1_2013).should be_empty					
        	end
        end

		context "when there are failures for one test suite and test category on a given day" do			
			before do				
				create_class_errors(@test_suite1,class_error_hash_from("001","002","003"))
				@expected_errors = class_name_arr_from("001","002","003")
			end
			it "should return records from the test suite " do				
				records_with_error_for(@sub_project,@unit_tests,@jan_1_2013).should contain_all(@expected_errors)				
			end
		end

		context "when there are failures for multiple test suites for a test category on a given day" do 
			before do				
				@test_suite2 = create_suite_with_metadata(@metadata1,"rest_unit_tests")
				create_class_errors(@test_suite1,class_error_hash_from("001","002","003"))
				create_class_errors(@test_suite2,class_error_hash_from("004","005","006"))
				@expected_errors = class_name_arr_from("001","002","003","004","005","006")
			end
			it "should return records from all test suites" do 
				records_with_error_for(@sub_project,@unit_tests,@jan_1_2013).should contain_all(@expected_errors)
			end
		end

	end


	describe "#getCompareResult" do 

		
		


	end


end
