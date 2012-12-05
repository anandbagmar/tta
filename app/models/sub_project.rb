class SubProject < ActiveRecord::Base
  has_many :project_metadatum
  attr_accessible :name

  validates :name, :presence => {:message => 'cannot be blank, Task not saved'}
end