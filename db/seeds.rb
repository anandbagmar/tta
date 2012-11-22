# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts "Seed data goes here!!"
  #Project.delete_all
  #ProjectMetaDatum.delete_all
  #TestRecord.delete_all
  1.upto(2) do |i|
    project = Project.create(:name => "PROJECT #{i}",
                   :type_of_report => "Junit",
                   :authorization_level => "ALL")
    project.save
  end

  1.upto(5) do |i|
    project_metadata = ProjectMetadatum.create(:os_name => "Mac OS",
                                               :host_name => "Test Machine",
                                               :browser => "Firefox",
                                               :date_of_execution => Date.current ,
                                               :user_timezone => Time.zone)

    project_metadata.project = Project.find(1)
    project_metadata.save

    end

    1.upto(5) do |i|
    project_metadata = ProjectMetadatum.create(:os_name => "Windows OS",
                                               :host_name => "Test Machine",
                                               :browser => "Chrome",
                                               :date_of_execution => Date.current ,
                                               :user_timezone => Time.zone)

    project_metadata.project = Project.find(2)
    project_metadata.save
  end

1.upto(200) do |i|
    test_record = TestRecord.create(:class_name => "services.gateways.BenefitsServiceGatewayTest" ,
                                    :number_of_tests=> "#{i+60}" ,
                                    :number_of_failures => "#{i}" ,
                                    :number_of_errors => "#{i}" ,
                                    :time_taken => "10")
    test_record.project_metadatum = ProjectMetadatum.find(1)
    test_record.save
    puts "Seed data done!!"
    end

1.upto(200) do |i|
    test_record = TestRecord.create(:class_name => "services.gateways.BenefitsServiceGatewayTest" ,
                                    :number_of_tests=> "#{i+60}" ,
                                    :number_of_failures => "#{i-1}" ,
                                    :number_of_errors => "#{i+1}" ,
                                    :time_taken => "8")
    test_record.project_metadatum = ProjectMetadatum.find(2)
    test_record.save
    puts "Seed data done!!"
  end