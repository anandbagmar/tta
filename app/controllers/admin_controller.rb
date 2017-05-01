class AdminController < ApplicationController

  def default
    @all_external_urls = ExternalDashboard.select("name, link").to_json
  end

  def view
    projects=Project.all
    @json = Admin.get_result_json(projects)
  end

  def add
    external_dashboard_name = params[:name]
    external_dashboard_link = params[:link]

    unless external_dashboard_link.include?('http')
      external_dashboard_link = "http://" + external_dashboard_link
    end

    if ExternalDashboard.find_by_name(external_dashboard_name)
      Admin.update_external_dashboard_link(external_dashboard_name,external_dashboard_link)
    else
      Admin.add_external_dashboard(external_dashboard_name, external_dashboard_link)
    end

    @all_external_urls = ExternalDashboard.select("name,link").to_json
    render :default
  end
end
