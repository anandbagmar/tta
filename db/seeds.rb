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


##Create seed data
browser_arr= %w( chrome firefox IE opera safari seamonkey k-meleon conqueror maxthon galleon avant netscape iCab camino flock )

os_arr= ["Mac","Unix","Ubuntu","BeOS","IRIX","NeXTSTEP","MS-DOS","iOS", "Windows7", "kondara linux", "OSF","QNX","SCO", "sunSolaris","SuSELinux"]

hostname_arr= %w(garima pooja ashwin nikita nikitha tushar matty lava priti sailee sanchari shilpa pranjali akshay aasawaree)

ci_arr= %w(smoke master regression runtest testomania enternet titanic kanha kaziranga stress opensaysme gir test4treasure quovadis nihao)
env_arr = %w(dev qa production uat)
test_cat_arr = [ "Unit test", "Integration test", "Functional test "]
test_rep_arr = %w(Junit Nunit Rspec Cucumber)
count = 0


1.upto(10) do |i|
  project = Project.create(:name => "PROJECT #{i}",
                           :authorization_level => "ALL")
  project.save

  1.upto(10) do |j|
    sub_project= SubProject.create(:name => "Sub_project #{i}.#{j}")
    sub_project.project_id= i
    sub_project.save

    1.upto(10) do  |k|
      if count >= 3
        count=0
      end
      meta_data = TestMetadatum.create(:id => k ,:ci_job_name => ci_arr[rand(ci_arr.length)] ,:os_name => os_arr[rand(os_arr.length)] , :host_name => hostname_arr[rand(hostname_arr.length)],:browser => browser_arr[rand(browser_arr.length)], :type_of_environment => env_arr[rand(env_arr.length)], :date_of_execution => Time.at(rand * Time.now.to_i) , :test_category => test_cat_arr[count], :test_report_type => test_rep_arr[rand(test_rep_arr.length)]  )
      meta_data.sub_project_id= (i*10)-10+j
      count = count + 1
      meta_data.save

      1.upto(10) do |l|

        test_record = TestRecord.create(:class_name => "Class #{i}.#{j}.#{k}.#{l}",:number_of_tests => rand(25..50),:number_of_errors =>rand(12) , :number_of_failures => rand(12),:time_taken => rand(1..5).to_s)
        test_record.test_metadatum_id= (i*100)-100+(j*10)-10+k
        test_record.save



      end

    end
  end

end