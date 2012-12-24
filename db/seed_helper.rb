module Seed
  module Helper
    def self.create_seed_data(number_of_projects, number_of_subprojects_per_project, number_of_test_metadatum_per_subproject, number_of_test_records_per_test_metadatum)
      puts "Seeding data in DB with:"
      puts "\tnumber_of_projects\t\t\t\t:#{number_of_projects}"
      puts "\tnumber_of_subprojects_per_project\t\t:#{number_of_subprojects_per_project}"
      puts "\tnumber_of_test_metadatum_per_subproject\t\t:#{number_of_test_metadatum_per_subproject}"
      puts "\tnumber_of_test_records_per_test_metadatum\t:#{number_of_test_records_per_test_metadatum}"

      number_of_projects.times do |project_number|
        create_project(project_number)
        number_of_subprojects_per_project.times do |sub_project_number|
          create_sub_project(project_number, sub_project_number)
          number_of_test_metadatum_per_subproject.times do |test_meta_data_number|
            create_test_meta_data(project_number, sub_project_number, test_meta_data_number)
            number_of_test_records_per_test_metadatum.times do |test_record_number|
              create_test_record(test_meta_data_number, test_record_number, project_number, sub_project_number)
            end
          end
        end
      end
    end

    def self.create_test_meta_data(project_number, sub_project_number, test_meta_data_number)
      #puts "\t\tcreating test_metadatum #{test_meta_data_number}"
      test_meta_data = TestMetadatum.create(
          :id => test_meta_data_number,
          :ci_job_name => SAMPLE_CI_JOB_NAMES[rand(SAMPLE_CI_JOB_NAMES.length)],
          :os_name => SAMPLE_OS_TYPES[rand(SAMPLE_OS_TYPES.length)],
          :host_name => SAMPLE_HOST_NAMES[rand(SAMPLE_HOST_NAMES.length)],
          :browser => SAMPLE_BROWSER_TYPES[rand(SAMPLE_BROWSER_TYPES.length)],
          :type_of_environment => SAMPLE_TEST_ENVIRONMENTS[rand(SAMPLE_TEST_ENVIRONMENTS.length)],
          :date_of_execution => Time.at(rand * Time.now.to_i),
          :test_category => SAMPLE_TEST_CATEGORIES[Time.now.to_i%(SAMPLE_TEST_CATEGORIES.length)],
          :test_report_type => SAMPLE_TEST_REPORT_TYPES[rand(SAMPLE_TEST_REPORT_TYPES.length)])
      test_meta_data.sub_project_id= (project_number*2)-2+sub_project_number
      test_meta_data.save
    end

    def self.create_project(project_number)
      #puts "creating project #{project_number}"
      project = Project.create(:name => "PROJECT #{project_number}",
                               :authorization_level => "ALL")
      project.save
    end

    def self.create_sub_project(project_number, sub_project_number)
      #puts "\tcreating sub_project #{sub_project_number}"
      sub_project= SubProject.create(:name => "Sub_project #{project_number}.#{sub_project_number}")
      sub_project.project_id= project_number
      sub_project.save
    end

    def self.create_test_record(test_meta_data_number, test_record_number, project_number, sub_project_number)
      test_record = TestRecord.create(:class_name => "Class #{project_number}.#{sub_project_number}.#{test_meta_data_number}.#{test_record_number}", :number_of_tests => rand(25..50), :number_of_errors => rand(12), :number_of_failures => rand(12), :time_taken => rand(1..5).to_s)
      test_record.test_metadatum_id= (project_number*4)-4+(sub_project_number*2)-2+test_meta_data_number
      test_record.save
    end
  end
end

