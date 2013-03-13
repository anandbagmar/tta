class TestSuiteRecord < ActiveRecord::Base
  has_many :test_case_records
  belongs_to :test_metadatum
  attr_accessible :class_name, :number_of_errors, :number_of_failures, :number_of_tests, :time_taken, :number_of_tests_not_run, :number_of_tests_ignored

  def self.get_class_name_suite_id_hash (metadata_one_id, metadata_two_id)
    test_suite_record1= TestSuiteRecord.select("id,class_name").find_all_by_test_metadatum_id(metadata_one_id)
    test_suite_record2= TestSuiteRecord.select("id,class_name").find_all_by_test_metadatum_id(metadata_two_id)
    result_hash = Hash.new
    result_hash = get_test_suite_hash(test_suite_record1,result_hash,0)
    result_hash = get_test_suite_hash(test_suite_record2,result_hash,1)
  end

  def self.get_test_suite_hash(test_suite_records,result_hash,arr_no)
    if !(test_suite_records.nil?)
      test_suite_records.each do |test_suite_record|
        result_hash[test_suite_record.class_name] = [[],[]] unless result_hash.keys.include?(test_suite_record.class_name)
        result_hash[test_suite_record.class_name][arr_no] << test_suite_record.id unless result_hash.nil?
      end
    end
    result_hash
  end
end





#if !(test_suite_records.nil?)
#  test_suite_records.each do |test_suite_record|
#    result_hash[test_suite_record.class_name] = [] unless result_hash.keys.include?(test_suite_record.class_name)
#    result_hash[test_suite_record.class_name].push(run_no => test_suite_record.id) unless result_hash.nil?
#  end
#end