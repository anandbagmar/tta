class ProjectMetadatum < ActiveRecord::Base
  belongs_to :project
  attr_accessible :sub_project_name, :browser,:type_of_enviornment , :date_of_execution, :host_name, :os_name, :user_timezone
  #validates_presence_of :project
end
