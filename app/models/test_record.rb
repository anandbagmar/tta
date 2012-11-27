class TestRecord < ActiveRecord::Base
  belongs_to :project_metadatum
  attr_accessible :class_name, :number_of_errors, :number_of_failures, :number_of_tests, :time_taken



end
