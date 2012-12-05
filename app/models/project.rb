class Project < ActiveRecord::Base
  has_many :sub_projects
  attr_accessible :authorization_level, :name
  validates_uniqueness_of :name
  validates_presence_of :name
end
