class TestSuiteRecord < ActiveRecord::Base
  has_many :test_case_records
  belongs_to :test_metadatum
  attr_accessible :class_name, :number_of_errors, :number_of_failures, :number_of_tests, :time_taken,:number_of_tests_not_run,:number_of_tests_ignored

  def self.get_uniq_class_names_between_two_runs (metadata_one_id,metadata_two_id)
     metadata_ids=[metadata_one_id,metadata_two_id]
     @class_names=TestSuiteRecord.find_all_by_test_metadatum_id(metadata_ids).map{|record| record.class_name}.uniq
  end


end
