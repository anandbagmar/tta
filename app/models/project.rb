class Project < ActiveRecord::Base
  has_many :project_metadata
  attr_accessible :authorization_level, :name, :type_of_test
  validates_uniqueness_of :name
  validates_presence_of :name
end
