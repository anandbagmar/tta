class HomeController < ApplicationController
  def index
    @all_external_urls = ExternalDashboard.select("name,link").to_json
    #binding.pry
  end
end