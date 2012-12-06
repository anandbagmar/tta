class TestMetadatum < ActiveRecord::Base

  has_many :test_records
  attr_accessible :ci_job_name, :browser,:type_of_environment , :date_of_execution, :host_name, :os_name, :user_timezone, :test_category, :test_report_type



  validates :browser, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :type_of_environment, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :host_name, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :os_name, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :date_of_execution, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :test_category, :presence => {:message => 'cannot be blank, Task not saved'}
  validates :test_report_type, :presence => {:message => 'cannot be blank, Task not saved'}
end
