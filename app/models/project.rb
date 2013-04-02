class Project < ActiveRecord::Base
  has_many :sub_projects
  attr_accessible :authorization_level, :name
  validates_uniqueness_of :name
  validates_presence_of :name

  def add_sub_project(params)
    sub_project = sub_projects.find_or_create_by_name((params[:sub_project_name]).split.join(" ").upcase)
    meta_data = sub_project.create_dependency params
    return sub_project, meta_data
  end
end
