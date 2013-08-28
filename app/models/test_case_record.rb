class TestCaseRecord < ActiveRecord::Base
  belongs_to :test_suite_record
  attr_accessible :class_name, :time_taken, :error_msg

  def self.get_test_case_records_with_error(test_suite_record)
    TestCaseRecord.select("class_name, error_msg").where("test_suite_record_id = ? AND error_msg <> ?",test_suite_record.id, "").order("class_name")
  end

  def eql?(other)
  	self.class_name == other.class_name
  end
end
