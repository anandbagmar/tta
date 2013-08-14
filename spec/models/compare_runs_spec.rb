require 'rspec'
require File.expand_path("spec/helpers/comparesunsspechelper.rb")
require File.expand_path("spec/helpers/comparerunscustommatchers.rb")

describe "CompareRuns" do 

	include CompareRunsSpecHelper
	include CompareRunsCustomMatchers

	before(:each) do		
		perform_common_setup()
		create_new_project_and_subproject()
	end

	describe "#get_test_suite_records_with_errors_for" do 

        before do
            @metadata1 = create_metadatum(@sub_project,@jan_1_2013,@unit_tests) 
            @test_suite1 = create_suite_with_metadata(@metadata1,"rest_unit_tests")     
        end


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

        context "when there are failures for multiple test suites for different test category on a given day" do 
            before do
                @integration_tests = "INTEGRATION TESTS"
                @metadata2 = create_metadatum(@sub_project,@jan_1_2013,@integration_tests)
                @test_suite2 = create_suite_with_metadata(@metadata2,"rest_integration_tests")
                create_class_errors(@test_suite1,class_error_hash_from("UT001","UT002","UT003"))     
                create_class_errors(@test_suite2,class_error_hash_from("IT001","IT002","IT003"))
            end
            
            it "should return only the records for the requested test category and exclude others on the same day" do 
                expected_ut_errors = class_name_arr_from("UT001","UT002","UT003")
                expected_it_errors = class_name_arr_from("IT001","IT002","IT003")
                
                records_with_error_for(@sub_project,@unit_tests,@jan_1_2013).should contain_all(expected_ut_errors)
                records_with_error_for(@sub_project,@unit_tests,@jan_1_2013).should contain_none_of(expected_it_errors)
                
                records_with_error_for(@sub_project,@integration_tests,@jan_1_2013).should contain_all(expected_it_errors)
                records_with_error_for(@sub_project,@integration_tests,@jan_1_2013).should contain_none_of(expected_ut_errors)
            end
        end

        context "when there are failures for multiple test suites for the same category on different days" do 
            
            before do
                @metadata2 = create_metadatum(@sub_project,@jan_2_2013,@unit_tests)
                @test_suite2 = create_suite_with_metadata(@metadata2,"rest_integration_tests")
                create_class_errors(@test_suite1,class_error_hash_from("DAY1_1","DAY1_2","DAY1_3"))
                create_class_errors(@test_suite2,class_error_hash_from("DAY2_1","DAY2_2","DAY2_3"))
            end

            it "should return only the records for the requested day and exclude failures on other days" do
                expected_day_1_errors = class_name_arr_from("DAY1_1","DAY1_2","DAY1_3")
                expected_day_2_errors = class_name_arr_from("DAY2_1","DAY2_2","DAY2_3")

                records_with_error_for(@sub_project,@unit_tests,@jan_1_2013).should contain_all(expected_day_1_errors)
                records_with_error_for(@sub_project,@unit_tests,@jan_1_2013).should contain_none_of(expected_day_2_errors)

                records_with_error_for(@sub_project,@unit_tests,@jan_2_2013).should contain_all(expected_day_2_errors)
                records_with_error_for(@sub_project,@unit_tests,@jan_2_2013).should contain_none_of(expected_day_1_errors)
            end
        end
	end


	describe "#getCompareResult" do 

        before do 
            @metadata1 = create_metadatum(@sub_project,@jan_1_2013,@unit_tests)
            @metadata2 = create_metadatum(@sub_project,@jan_2_2013,@unit_tests)
            
            @test_suite1 = create_suite_with_metadata(@metadata1,"rest_unit_tests")
            @test_suite2 = create_suite_with_metadata(@metadata2,"rest_unit_tests")
        end

        context "when there are no failures on the test runs being compared" do
          it "returns no records for combined , common , day1 and day2 failures" do 
                get_compare_result()
                common_test_failures.should be_empty
                combined_test_failures.should be_empty 
                day_one_test_failures.should be_empty
                day_two_test_failures.should be_empty                
            end
        end

        context "when the test runs being compared have mutual exclusive failures" do 

            before do
                create_class_errors(@test_suite1,class_error_hash_from("001","002","003"))
                create_class_errors(@test_suite2,class_error_hash_from("004","005","006"))
                @expected_combined_failures = class_name_arr_from "001","002","003","004","005","006" 
                @expected_day_1_failures = class_name_arr_from "001","002","003" 
                @expected_day_2_failures = class_name_arr_from "004","005","006" 
                get_compare_result()
            end

            it "returns no tests as common failures" do 
                common_test_failures.should be_empty
            end

            it "returns all failed tests as combined test failures" do                
                combined_test_failures.should contain_all @expected_combined_failures 
            end

            it "returns only failures from day 1 as tests failed for day 1" do
                day_one_test_failures.should contain_all @expected_day_1_failures 
                day_one_test_failures.should contain_none_of @expected_day_2_failures 
            end

            it "returns only failures from day 2 as tests failed for day 2" do
                day_two_test_failures.should contain_all @expected_day_2_failures 
                day_two_test_failures.should contain_none_of @expected_day_1_failures 
            end
        
        end

        context "when only day 1 has failures" do 

            before do
                create_class_errors(@test_suite1,class_error_hash_from("001","002","003"))
                @expected_day_1_failures = class_name_arr_from "001","002","003"
                get_compare_result()
            end

            it "returns no tests as common failures" do 
                common_test_failures.should be_empty
            end

            it "returns failures from day 1 as combined test failures" do
                combined_test_failures.should contain_all @expected_day_1_failures 
            end

            it "returns failures from day 1 as tests failed for day 1" do
                day_one_test_failures.should contain_all @expected_day_1_failures 
            end

            it "returns no records as tests failed for day 2" do
               day_two_test_failures.should be_empty
            end

        end

        context "when only day 2 has failures" do

            before do
                create_class_errors(@test_suite2,class_error_hash_from("004","005","006"))
                @expected_day_2_failures = class_name_arr_from "004","005","006"
                get_compare_result()
            end

            it "returns no tests as common failures" do 
                common_test_failures.should be_empty
            end

            it "returns failures from day 2 as combined test failures" do
                combined_test_failures.should contain_all @expected_day_2_failures 
            end

            it "returns failures from day 2 as tests failed for day 2" do
                day_two_test_failures.should contain_all @expected_day_2_failures 
            end

            it "returns no records as tests failed for day 1" do
               day_one_test_failures.should be_empty
            end
        end

        context "when the test runs have exact same failures" do 
            
            before do
                create_class_errors @test_suite1, class_error_hash_from("001","002","003") 
                create_class_errors @test_suite2, class_error_hash_from("001","002","003") 
                get_compare_result()
                @expected_failures = class_name_arr_from "001", "002", "003"
            end

            it "should return all test failures as common failures , combined_failures , day1 failures and day 2 failures" do 
                common_test_failures.should contain_all @expected_failures
                combined_test_failures.should contain_all @expected_failures
                day_one_test_failures.should contain_all @expected_failures
                day_two_test_failures.should contain_all @expected_failures
            end
        end

        context "when the test runs have some common failures" do
            
            before do
                create_class_errors @test_suite1, class_error_hash_from("001","002","003") 
                create_class_errors @test_suite2, class_error_hash_from("004","002","003") 
                get_compare_result()
                @expected_combined_failures = class_name_arr_from "001", "002", "003" ,"004"
                @expected_common_failures = class_name_arr_from "002", "003"
                @expected_day_1_failures = class_name_arr_from "001","002","003" 
                @expected_day_2_failures = class_name_arr_from "004","002","003" 
            end

            it "should return all test failures as combined failures" do 
               combined_test_failures.should contain_all @expected_combined_failures
            end

            it "should return test failed in both runs as common failures" do 
               common_test_failures.should contain_all  @expected_common_failures
            end

            it "returns failures from day 2 as tests failed for day 2" do
                day_two_test_failures.should contain_all @expected_day_2_failures 
            end

            it "returns failures from day 1 as tests failed for day 1" do
                day_one_test_failures.should contain_all @expected_day_1_failures 
            end
        end

        context "when failures from day 1 are a subset of failures from day 2" do 
            
            before do 
                create_class_errors @test_suite1, class_error_hash_from("001","002","003")
                create_class_errors @test_suite2, class_error_hash_from("001","004","002","003","005")
                get_compare_result()
                @expected_day_1_failures = class_name_arr_from "001","002","003" 
                @expected_day_2_failures = class_name_arr_from "001","004","002","003","005"
            end

            it "should return all failures from day 1 as common test failures" do 
                day_one_test_failures.should contain_all @expected_day_1_failures
                common_test_failures.should contain_all day_one_test_failures                

            end

            it "should return all failures from day 2 as combined test failures" do 
                day_two_test_failures.should contain_all @expected_day_2_failures
                combined_test_failures.should contain_all day_two_test_failures
            end            
        end

        context "when failures from day 2 are a subset of failures from day 1" do 
                    
            before do 
                create_class_errors @test_suite1, class_error_hash_from("001","004","002","003","005")
                create_class_errors @test_suite2, class_error_hash_from("001","002","003")
                get_compare_result()
                @expected_day_1_failures = class_name_arr_from "001","004","002","003","005"
                @expected_day_2_failures = class_name_arr_from "001","002","003" 
            end

            it "should return all failures from day 2 as common test failures" do 
                day_two_test_failures.should contain_all @expected_day_2_failures
                common_test_failures.should contain_all day_two_test_failures                

            end

            it "should return all failures from day 1 as combined test failures" do 
                day_one_test_failures.should contain_all @expected_day_1_failures
                combined_test_failures.should contain_all day_one_test_failures
            end

        end

	end


end
