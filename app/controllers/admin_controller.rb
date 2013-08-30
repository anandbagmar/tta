class AdminController < ApplicationController

  def default
    @all_external_urls = ExternalDashboard.select("name,link").to_json
  end

  def view
    projects=Project.all
    @json = Admin.get_result_json(projects)
  end

  def add
    ExternalDashboard.find_or_create_by_name_and_link((params[:name]), params[:link])
    @all_external_urls = ExternalDashboard.select("name,link").to_json
    render :default
  end

  #def delete
  #  projects=Project.all
  #  @json = Admin.get_result_json(projects)
  #  @all_external_urls = ExternalDashboard.select("name,link").to_json
  #end

end
