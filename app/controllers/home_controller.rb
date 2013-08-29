class HomeController < ApplicationController
  def index
    #Get data from the external dashboard table
    @project = Hash.new
    @project["Jira"] = "http://www.w3schools.com"
    @project["Jenkins"] = "http://www.w3schools.com"
    @project["Go"] = "http://www.w3schools.com"
    @project = @project.to_json
  end
end