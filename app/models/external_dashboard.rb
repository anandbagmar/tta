class ExternalDashboard < ActiveRecord::Base
  attr_accessible :link, :name
  validates :link, :presence => { :message => 'cannot be blank, Task not saved' }
  validates :name, :presence => { :message => 'cannot be blank, Task not saved' }

end
