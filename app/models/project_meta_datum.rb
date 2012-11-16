class ProjectMetaDatum < ActiveRecord::Base
  attr_accessible :browser, :date_of_execution, :host_name, :os_name, :project_id, :user_timezone
end
