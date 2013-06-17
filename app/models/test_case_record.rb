class TestCaseRecord < ActiveRecord::Base
  belongs_to :test_suite_record
  attr_accessible :class_name, :time_taken, :error_msg

  def self.get_test_case_records_with_error(test_suite_record)
    TestCaseRecord.select("class_name, error_msg").find(:all, :conditions => ["test_suite_record_id = #{test_suite_record.id}", "error_msg != ''"], :order => "class_name ASC")
  end
end
