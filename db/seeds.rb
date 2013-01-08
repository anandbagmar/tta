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
TestSuiteRecord.destroy_all
TestSuiteRecord.reset_primary_key

require_relative 'common_seed_data'
require_relative 'seed_helper'

number_of_projects=2
number_of_subprojects_per_project=2
number_of_test_metadatum_per_subproject=3
number_of_test_suite_records_per_test_metadatum=3
number_of_test_case_records_per_test_suite_record=3

Seed::Helper.create_seed_data(number_of_projects, number_of_subprojects_per_project, number_of_test_metadatum_per_subproject, number_of_test_suite_records_per_test_metadatum,number_of_test_case_records_per_test_suite_record)