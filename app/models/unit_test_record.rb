class UnitTestRecord < ActiveRecord::Base
  belongs_to :project
  attr_accessible :class_name, :number_of_errors, :number_of_failures, :number_of_tests, :project_id, :project_metadata_id, :time_taken
end
