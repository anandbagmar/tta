require_relative 'common_seed_data'
require_relative 'create_demo_seed_data'

DEMODATA = YAML.load(File.open("#{Rails.root}/config/demo.yml", "r"))

randomizer = (Time.now.hash%3600).to_s

DEMODATA.each do |project|
  project_name = project[0] + randomizer
  puts project_name
  project_id=create_demo_project(project_name)
  project[1].each do |sub_project_data|
    sub_project_data.each do |metadata|
      sub_project_name = metadata[0] + randomizer
      sub_project_tag_name=sub_project_name.match(/\d+[,.]\d+/)[0]
      sub_project_id=create_demo_sub_project(project_id, sub_project_name)
      (1..metadata[1][0]["MAX_METADATA_ROWS"]).each do |meta_record|
        puts "*********** META DATA RECORD " + meta_record.to_s + "**************"
        date_of_execution = get_random_demo_date_of_execution(metadata[1][5]["DATA_RANGE_FOR_METADATA_UPLOAD"])
        meta_data_record_id=create_demo_test_meta_data(sub_project_id, date_of_execution)
        (1..metadata[1][1]["MAX_TESTSUITE_ROWS"]).each do |test_suite_record|
          total_time_taken=0
          class_name_for_test_suite_record = "Test Suite "+sub_project_tag_name+"."+test_suite_record.to_s
          number_of_tests = metadata[1][2]["MAX_NUMBER_OF_TEST_OR_FAILURE_FOR_EVERY_TEST_SUITE"]
          test_suite_record_id, number_of_failing_tests=create_demo_test_suite_record(meta_data_record_id, class_name_for_test_suite_record, number_of_tests)
          test_suite=TestSuiteRecord.find_by_id(test_suite_record_id)
          (1..metadata[1][3]["MAX_TESTCASE_ROWS"]).each do |test_case_record|
            class_name_for_test_case_record ="Test Case "+sub_project_tag_name+"."+test_suite_record.to_s+"."+test_case_record.to_s
            time_taken=rand(1.0..metadata[1][4]["MAX_TIME_TAKEN_FOR_INDIVIDUAL_TEST_TO_RUN"]).round(5)
            if number_of_failing_tests ==0
              error_msg=""
            else
              error_msg_list = [sub_project_tag_name ,meta_record.to_s+"."+test_case_record.to_s,class_name_for_test_case_record]
              error_msg="Error Message for Class #{error_msg_list[rand(error_msg_list.length)]}"
            end
            create_demo_test_case_record(test_suite_record_id, class_name_for_test_case_record, time_taken, error_msg)
            total_time_taken+=time_taken
          end
          test_suite.time_taken=total_time_taken
          test_suite.save
        end
      end
    end
  end
end
