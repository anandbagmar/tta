class Project < ActiveRecord::Base
  has_many :project_metadata
  attr_accessible :authorization_level, :name, :type_of_test
  validates_uniqueness_of :name
=begin
  validates :name, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :type_of_report, :presence => {:message => 'cannot be blank, Task not saved'}
=end
end
