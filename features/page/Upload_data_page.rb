
module Page
  module Upload_dataPage

    def navigate_to_upload_page
      go_to_url(UPLOAD_PAGE)
    end

    def upload_data_and_submit(proj_params)
      proj_params[:logFile]=$PROJECT_ROOT+"/"+proj_params[:logFile]
      form_filling(proj_params[:proj],proj_params[:sub_proj],proj_params[:ci_job],proj_params[:osName],proj_params[:hostName],proj_params[:browser],proj_params[:environment],proj_params[:date_year],proj_params[:date_month],proj_params[:date_day],proj_params[:date_hour],proj_params[:date_minute],proj_params[:logFile],proj_params[:test_type])
      clickButton(UPLOAD_PAGE_BUTTON)
    end

    def go_to_url(button)
      clickButton(button)
    end


  end
end

World(Page::Upload_dataPage)