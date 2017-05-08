class TestStepRecord < ActiveRecord::Base
  belongs_to :test_case_record
  attr_accessible :step_name, :step_description, :status, :time_taken
end