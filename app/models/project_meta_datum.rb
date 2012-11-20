class ProjectMetaDatum < ActiveRecord::Base
  belongs_to :project
  attr_accessible :browser, :date_of_execution, :host_name, :os_name, :user_timezone
end
