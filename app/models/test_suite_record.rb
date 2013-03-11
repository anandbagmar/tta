class TestSuiteRecord < ActiveRecord::Base
  has_many :test_case_records
  belongs_to :test_metadatum
  attr_accessible :class_name, :number_of_errors, :number_of_failures, :number_of_tests, :time_taken,:number_of_tests_not_run,:number_of_tests_ignored

  def initialize(test_metadatum_id,class_name,number_of_errors,number_of_failure,number_of_test,time_taken,number_of_tests_not_run,number_of_tests_ignored)
    self.test_metadatum_id = test_metadatum_id
    self.class_name =class_name
    self.number_of_errors = number_of_errors
    self.number_of_failure = number_of_failure
    self.number_of_test = number_of_test
    self.time_taken = time_taken
    self.number_of_tests_not_run = number_of_tests_not_run
    self.number_of_tests_ignored = number_of_tests_ignored
  end

  def self.create_and_save(hash)
    test_suite = TestSuiteRecord.new(hash[:test_metadatum_id],hash[:class_name],hash[:number_of_errors],hash[:number_of_failure],hash[:number_of_test],hash[:time_taken],hash[:number_of_tests_not_run],hash[:number_of_tests_ignored])
    test_suite.save
    test_suite
  end
end
