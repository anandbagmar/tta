def self.create_demo_project(project_name)
  puts "\t creating project " + project_name
  project = Project.create(:name => project_name, :authorization_level => "ALL")
  project.save
  Project.find_by_name(project_name).id
end


def self.create_demo_sub_project(project_id, sub_project_name)
  puts "\t creating sub_project #{sub_project_name}"
  sub_project= SubProject.create(:name => sub_project_name)
  sub_project.project_id= project_id
  sub_project.save
  SubProject.find_by_name(sub_project_name).id
end

def self.get_respective_demo_test_sub_category(test_category)
  SAMPLE_TEST_SUB_CATEGORY[test_category][rand(SAMPLE_TEST_SUB_CATEGORY[test_category].length)]
end

def self.create_demo_test_meta_data(sub_project_id, date_of_execution)
  test_category = SAMPLE_TEST_CATEGORIES[rand(SAMPLE_TEST_CATEGORIES.length)]
  test_sub_category = get_respective_demo_test_sub_category(test_category)
  test_meta_data = TestMetadatum.create(
      :ci_job_name => SAMPLE_CI_JOB_NAMES[rand(SAMPLE_CI_JOB_NAMES.length)],
      :os_name => SAMPLE_OS_TYPES[rand(SAMPLE_OS_TYPES.length)],
      :host_name => SAMPLE_HOST_NAMES[rand(SAMPLE_HOST_NAMES.length)],
      :browser => SAMPLE_BROWSER_TYPES[rand(SAMPLE_BROWSER_TYPES.length)],
      :type_of_environment => SAMPLE_TEST_ENVIRONMENTS[rand(SAMPLE_TEST_ENVIRONMENTS.length)],
      :date_of_execution => date_of_execution,
      :test_category => test_category,
      :test_sub_category => test_sub_category,
      :test_report_type => SAMPLE_TEST_REPORT_TYPES[rand(SAMPLE_TEST_REPORT_TYPES.length)])
  test_meta_data.sub_project_id= sub_project_id
  test_meta_data.save
  TestMetadatum.where(:sub_project_id => sub_project_id).last.id
end

def self.create_demo_test_suite_record(meta_data_record_id,test_suite_class_name,max_number_of_tests)
  number_of_tests= rand(1..max_number_of_tests)
  number_of_failing_tests=rand(number_of_tests)
  test_suite_record = TestSuiteRecord.create_and_save(:test_metadatum_id => meta_data_record_id, :class_name => test_suite_class_name, :number_of_tests => number_of_tests, :number_of_errors => 0, :number_of_failures => number_of_failing_tests, :time_taken => 0)
  return test_suite_record.id,number_of_failing_tests
end

def self.create_demo_test_case_record(test_suite_record_id,test_case_class_name,time_taken,error_msg)
  test_case_record = TestCaseRecord.create(:class_name => test_case_class_name, :time_taken => time_taken, :error_msg => error_msg)
  test_case_record.test_suite_record_id= test_suite_record_id
  test_case_record.save
end

def self.get_random_demo_date_of_execution(preceding_number_of_days)
  today = Time.now.to_i
  from_date = today- 60 * 60 * 24* preceding_number_of_days
  Time.at(rand(from_date..today))
end
