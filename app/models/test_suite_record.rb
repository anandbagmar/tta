class TestSuiteRecord < ActiveRecord::Base
  has_many :test_case_records
  belongs_to :test_metadatum
  attr_accessible :class_name, :number_of_errors, :number_of_failures, :number_of_tests, :time_taken,:number_of_tests_not_run,:number_of_tests_ignored

end
