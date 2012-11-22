class Project < ActiveRecord::Base
  has_many :test_records
  has_many :project_meta_data
  attr_accessible :authorization_level, :name, :type_of_report
end
