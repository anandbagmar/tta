class TestStepRecord < ActiveRecord::Base
  belongs_to :test_case_record
  attr_accessible :test_case_record_id, :step_name, :step_description, :status, :time_taken, :error_msg

  def self.create_and_save(hash)
    test_step = TestStepRecord.new(hash)
    test_step.save
    test_step
  end
end