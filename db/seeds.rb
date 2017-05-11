# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## Delete data from all tables
puts "Seeding data for #{ENV['RAILS_ENV']} environment"

Product.destroy_all
Product.reset_primary_key
Platform.destroy_all
Platform.reset_primary_key
TestMetadatum.destroy_all
TestMetadatum.reset_primary_key
TestSuiteRecord.destroy_all
TestSuiteRecord.reset_primary_key

require_relative 'common_seed_data'
require_relative 'seed_helper'

number_of_products                               =1
number_of_platforms_per_product                  =2
number_of_test_metadatum_per_platform            =2
number_of_test_suite_records_per_test_metadatum  =2
number_of_test_case_records_per_test_suite_record=3

Seed::Helper.create_seed_data(number_of_products, number_of_platforms_per_product, number_of_test_metadatum_per_platform, number_of_test_suite_records_per_test_metadatum, number_of_test_case_records_per_test_suite_record)