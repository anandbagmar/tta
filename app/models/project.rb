class Project < ActiveRecord::Base
  has_many :sub_projects
  attr_accessible :authorization_level, :name
  before_validation :uppercase_name
  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :name

  scope :get_all_projects, -> {
    Project.all
  }

  def add_sub_project(params)
    sub_projects.where(name: (params[:sub_project_name]).split.join(" ").upcase).first_or_create
  end

  private
    def uppercase_name
        self.name.upcase! if !self.name.nil?
    end
end
