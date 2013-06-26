class TestSuiteRecord < ActiveRecord::Base
  has_many :test_case_records
  belongs_to :test_metadatum
  attr_accessible :class_name, :number_of_errors, :number_of_failures, :number_of_tests, :time_taken,:number_of_tests_not_run,:number_of_tests_ignored,:test_metadatum_id

  def self.get_test_suite_records(test_meta_data)
    TestSuiteRecord.select("id").find_all_by_test_metadatum_id(test_meta_data)
  end

  # This method is here to make specs for compare run to pass
  def self.get_class_name_suite_id_hash(metadata_one_id, metadata_two_id)
    test_suite_record1= TestSuiteRecord.select("id,class_name").find_all_by_test_metadatum_id(metadata_one_id)
    test_suite_record2= TestSuiteRecord.select("id,class_name").find_all_by_test_metadatum_id(metadata_two_id)

    result_hash = Hash.new

    result_hash = get_test_suite_hash(test_suite_record1,result_hash,0)
    result_hash = get_test_suite_hash(test_suite_record2,result_hash,1)
    result_hash
  end

  # This method is here to make specs for compare run to pass
  def self.get_test_suite_hash(test_suite_records,result_hash,arr_no)
    if !(test_suite_records.nil?)
      test_suite_records.each do |test_suite_record|
        result_hash[test_suite_record.class_name] = [[],[]] unless result_hash.keys.include?(test_suite_record.class_name)
        result_hash[test_suite_record.class_name][arr_no] << test_suite_record.id unless result_hash.nil?
      end
    end
    result_hash
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