class TestSuiteRecord < ActiveRecord::Base
  has_many :test_case_records
  belongs_to :test_metadatum
  attr_accessible :class_name, :number_of_errors, :number_of_failures, :number_of_tests, :time_taken,:number_of_tests_not_run,:number_of_tests_ignored,:test_metadatum_id

  def self.get_test_suite_records(test_meta_data)
    TestSuiteRecord.select("id").find_all_by_test_metadatum_id(test_meta_data)
  end

  def after_initialize(hash)
    @test_metadatum_id = hash[:test_metadatum_id]
    @class_name =hash[:class_name]
    @number_of_errors = initilize_to_zero_if_nil(hash[:number_of_errors])
    @number_of_failure = initilize_to_zero_if_nil(hash[:number_of_failure])
    @number_of_test = hash[:number_of_test]
    @time_taken = hash[:time_taken]
    @number_of_tests_not_run = initilize_to_zero_if_nil(hash[:number_of_tests_not_run])
    @number_of_tests_ignored = initilize_to_zero_if_nil(hash[:number_of_tests_ignored])
  end

  def self.create_and_save(hash)
    test_suite = TestSuiteRecord.new(hash)
    test_suite.save
    test_suite
  end

  def initilize_to_zero_if_nil(value)
    value.nil? ? 0 : value
  end
end