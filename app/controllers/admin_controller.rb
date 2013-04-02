class AdminController < ApplicationController
  def view
    projects=Project.all
    @json = Admin.get_result_json(projects)
  end
end
