require_relative 'common_seed_data'
module Seed
  module Helper
    def self.create_seed_data(number_of_projects, number_of_subprojects_per_project, number_of_test_metadatum_per_subproject, number_of_test_suite_records_per_test_metadatum, number_of_test_case_records_per_test_suite_record)
      puts "Seeding data in DB with:"
      puts "\tnumber_of_projects\t\t\t\t:#{number_of_projects}"
      puts "\tnumber_of_subprojects_per_project\t\t:#{number_of_subprojects_per_project}"
      puts "\tnumber_of_test_metadatum_per_subproject\t\t:#{number_of_test_metadatum_per_subproject}"
      puts "\tnumber_of_test_suite_records_per_test_metadatum\t:#{number_of_test_suite_records_per_test_metadatum}"
      puts "\tnumber_of_test_case_records_per_test_suite_record:#{number_of_test_case_records_per_test_suite_record}"

      (1..number_of_projects).each do |project_number|
        project_id = create_project(project_number)
        (1..number_of_subprojects_per_project).each do |sub_project_number|
          sub_project_id = create_sub_project(project_id, sub_project_number)
          (1..number_of_test_metadatum_per_subproject).each do |test_meta_data_number|
            test_meta_data_id = create_test_meta_data(sub_project_id, test_meta_data_number)
            (1..number_of_test_suite_records_per_test_metadatum).each do |test_suite_record_number|
              test_suite_record_id = create_test_suite_record(test_meta_data_id, project_id, sub_project_id, test_suite_record_number)
              (1..number_of_test_case_records_per_test_suite_record).each do |test_case_record_number|
                create_test_case_record(test_suite_record_id, project_id, sub_project_id, test_case_record_number)
              end
            end
          end
        end
      end
    end

    def self.create_test_meta_data(sub_project_id, test_meta_data_number)
      test_category = SAMPLE_TEST_CATEGORIES[rand(SAMPLE_TEST_CATEGORIES.length)]
      test_sub_category = get_respective_test_sub_category(test_category)
      random_time = (DateTime.now - (test_meta_data_number + test_meta_data_number%10.to_f)).to_time
      test_meta_data = TestMetadatum.create(
          :ci_job_name => SAMPLE_CI_JOB_NAMES[rand(SAMPLE_CI_JOB_NAMES.length)],
          :os_name => SAMPLE_OS_TYPES[rand(SAMPLE_OS_TYPES.length)],
          :host_name => SAMPLE_HOST_NAMES[rand(SAMPLE_HOST_NAMES.length)],
          :browser => SAMPLE_BROWSER_TYPES[rand(SAMPLE_BROWSER_TYPES.length)],
          :type_of_environment => SAMPLE_TEST_ENVIRONMENTS[rand(SAMPLE_TEST_ENVIRONMENTS.length)],
          :date_of_execution => random_time,
          :test_category => test_category,
          :test_sub_category => test_sub_category,
          :test_report_type => SAMPLE_TEST_REPORT_TYPES[rand(SAMPLE_TEST_REPORT_TYPES.length)])
      test_meta_data.sub_project_id= sub_project_id
      test_meta_data.save
      TestMetadatum.where(:sub_project_id => sub_project_id).last.id
    end

    def self.get_respective_test_sub_category(test_category)
      SAMPLE_TEST_SUB_CATEGORY[test_category][rand(SAMPLE_TEST_SUB_CATEGORY[test_category].length)]
    end

    def self.create_project(project_number)
      #puts "\t creating project #{project_number}"
      project_name = "PROJECT #{project_number}"
      project = Project.create(:name => project_name,
                               :authorization_level => "ALL")
      project.save
      Project.find_by_name(project_name).id
    end

    def self.create_sub_project(project_id, sub_project_number)
      #puts "\t creating sub_project #{sub_project_number}"
      sub_project_name = "Sub_project #{project_id}.#{sub_project_number}"
      sub_project= SubProject.create(:name => sub_project_name)
      sub_project.project_id= project_id
      sub_project.save
      SubProject.find_by_name(sub_project_name).id
    end

    def self.create_test_suite_record(test_meta_data_id, project_id, sub_project_id, test_suite_record_number)
      test_suite_record_name = "Class #{project_id}.#{sub_project_id}.#{test_meta_data_id}.#{test_suite_record_number}"

      test_suite_record = TestSuiteRecord.create_and_save(:test_metadatum_id => test_meta_data_id, :class_name => test_suite_record_name, :number_of_tests => rand(25..50), :number_of_errors => rand(12), :number_of_failures => rand(12), :time_taken => rand(1..5).to_s)
      test_suite_record.id
    end

    def self.create_test_case_record(test_suite_record_id, project_id, sub_project_id, test_case_record_number)
      test_case_record = TestCaseRecord.create(:class_name => "Class #{project_id}.#{sub_project_id}.#{test_suite_record_id}.#{test_case_record_number}", :time_taken => rand(1..4).to_s, :error_msg => "Error Message for Class - #{project_id}.#{sub_project_id}.#{test_suite_record_id}.#{test_case_record_number}")
      test_case_record.test_suite_record_id= test_suite_record_id
      test_case_record.save
    end
  end
end

