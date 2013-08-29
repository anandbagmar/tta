class AdminController < ApplicationController
  def view
    projects=Project.all
    @json = Admin.get_result_json(projects)
  end

  def add
    #Code for adding urls to database here
  end

  def delete
    #Delete the entry from db
  end

end
