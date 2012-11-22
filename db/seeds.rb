# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts "Seed data goes here!!"
  5.upto(20) do |i|
    TestRecord.create(:classname => "services.gateways.BenefitsServiceGatewayTest" , :number_of_tests=> "#{i+2}" , :number_of_failures => "#{i}" , :number_of_errors => "#{i}" , :time_taken => "10")
    puts "Seed data done!!"
  end