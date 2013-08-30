class AdminController < ApplicationController

  def default
    @all_external_urls = ExternalDashboard.select("name,link").to_json
  end

  def view
    projects=Project.all
    @json = Admin.get_result_json(projects)
  end

  def add
    if (ExternalDashboard.find_by_name(params[:name]))
      ExternalDashboard.find_by_name(params[:name]).update_column("link", params[:link])
    else
      ExternalDashboard.find_or_create_by_name_and_link((params[:name]), params[:link])
    end
    @all_external_urls = ExternalDashboard.select("name,link").to_json
    render :default
  end

end
