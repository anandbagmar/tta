class Project < ActiveRecord::Base
  has_many :unit_test_records
  has_many :project_metadata
  attr_accessible :authorization_level, :name, :type_of_report
  accepts_nested_attributes_for :project_metadata

end
