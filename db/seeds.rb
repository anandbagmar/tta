# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## Delete data from all tables
Project.destroy_all
Project.reset_primary_key
SubProject.destroy_all
SubProject.reset_primary_key
TestMetadatum.destroy_all
TestMetadatum.reset_primary_key
TestRecord.destroy_all
TestRecord.reset_primary_key


require_relative 'common_params'

count = 0


1.upto(2) do |i|
  project = Project.create(:name => "PROJECT #{i}",
                           :authorization_level => "ALL")
  project.save

  1.upto(2) do |j|
    sub_project= SubProject.create(:name => "Sub_project #{i}.#{j}")
    sub_project.project_id= i
    sub_project.save

    1.upto(2) do  |k|
      if count >= 3
        count=0
      end
      meta_data = TestMetadatum.create(
          :id => k ,:ci_job_name => SAMPLE_CI_JOB_NAMES[rand(SAMPLE_CI_JOB_NAMES.length)] ,
          :os_name => SAMPLE_OS_TYPES[rand(SAMPLE_OS_TYPES.length)] ,
          :host_name => SAMPLE_HOST_NAMES[rand(SAMPLE_HOST_NAMES.length)],
          :browser => SAMPLE_BROWSER_TYPES[rand(SAMPLE_BROWSER_TYPES.length)],
          :type_of_environment => SAMPLE_TEST_ENVIRONMENTS[rand(SAMPLE_TEST_ENVIRONMENTS.length)],
          :date_of_execution => Time.at(rand * Time.now.to_i) ,
          :test_category => SAMPLE_TEST_CATEGORIES[count],
          :test_report_type => SAMPLE_TEST_REPORT_TYPES[rand(SAMPLE_TEST_REPORT_TYPES.length)]  )
      meta_data.sub_project_id= (i*2)-2+j
      count = count + 1
      meta_data.save

      1.upto(2) do |l|

        test_record = TestRecord.create(:class_name => "Class #{i}.#{j}.#{k}.#{l}",:number_of_tests => rand(25..50),:number_of_errors =>rand(12) , :number_of_failures => rand(12),:time_taken => rand(1..5).to_s)
        test_record.test_metadatum_id= (i*4)-4+(j*2)-2+k
        test_record.save



      end

    end
  end

end