class TestCaseRecord < ActiveRecord::Base
  belongs_to :test_suite_record
  attr_accessible :class_name, :time_taken
end
