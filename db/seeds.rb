# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts "Seed data goes here!!"
  5.upto(20) do |i|
    TestRecord.create(:name => "services.gateways.BenefitsServiceGatewayTest" , :classname => "services.gateways.BenefitsServiceGatewayTest" , :tests=> "#{i+2}" , :failures => "#{i}" , :errorsintest => "#{i}" , :hostname => "test-machine" , :timetaken => "10")
    puts "Seed data done!!"
  end