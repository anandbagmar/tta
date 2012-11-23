# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

1.upto(2) do |i|
  project = Project.create(:name => "PROJECT #{i}",
                           :type_of_report => "Junit",
                           :authorization_level => "ALL")
  project.save
end

os_arr_data = ["Mac Os", "Windows 7", "Cent OS", "Ubuntu", "Vista"]
host_name_arr_data = ["Ritu ", "Khushal", "Khushboo", "Pooja", "Anand"]
browser_arr_data = ["Firefox ", "chrome", "IE", "Safari", "Google Chrome" ]

os_arr_data.each do |os_arr_data , host_name_arr_data , browser_arr_data |
  project_metadata = ProjectMetadatum.create(:os_name => os_arr_data,
                                             :host_name => host_name_arr_data,
                                             :browser => browser_arr_data ,
                                             :date_of_execution => Date.current ,
                                             :user_timezone => Time.zone)
  project_metadata.project = Project.find(1)
  project_metadata.save
end

os_arr_data.each do |os_arr_data , host_name_arr_data , browser_arr_data |
  project_metadata = ProjectMetadatum.create(:os_name => os_arr_data,
                                             :host_name => host_name_arr_data,
                                             :browser => browser_arr_data ,
                                             :date_of_execution => Date.current ,
                                             :user_timezone => Time.zone)
  project_metadata.project = Project.find(2)
  project_metadata.save

end

@test_arr_data =[10 , 30 , 40 , 50 , 60, 70, 90]
@failure_arr_data =[10 , 20 , 15, 2 ,44, 35,90]

@test_arr_data.zip @failure_arr_data
@test_arr_data.zip(@failure_arr_data) do |test_arr_data, failure_arr_data|
  test_record = TestRecord.create(:class_name => "services.gateways.BenefitsServiceGatewayTest" ,
                                  :number_of_tests=> test_arr_data ,
                                  :number_of_failures => failure_arr_data,
                                  :number_of_errors => "10" ,
                                  :time_taken => "10")
  test_record.project_metadatum = ProjectMetadatum.find(1)
  test_record.save

end