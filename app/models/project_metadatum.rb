class ProjectMetadatum < ActiveRecord::Base
  belongs_to :project
  attr_accessible :sub_project_name, :ci_job_name, :browser,:type_of_enviornment , :date_of_execution, :host_name, :os_name, :user_timezone


  validates :sub_project_name, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :browser, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :type_of_enviornment, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :host_name, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :os_name, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :date_of_execution, :presence => {:message => 'cannot be blank, Task not saved'}
end
