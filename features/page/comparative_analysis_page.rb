module Page
  module Comparative_Page


    def upload_data(proj_params)
      proj_params[:logFile]=$PROJECT_ROOT+"/"+proj_params[:logFile]
      form_filling(proj_params[:proj],proj_params[:sub_proj],proj_params[:ci_job],proj_params[:osName],proj_params[:hostName],proj_params[:browser],proj_params[:environment],proj_params[:date_year],proj_params[:date_month],proj_params[:date_day],proj_params[:date_hour],proj_params[:date_minute],proj_params[:logFile],proj_params[:test_type])
    end

    def view_graph(project, start_date, end_date)

      page.execute_script %Q{ $("#comparative_analysis_start_date").val("1990-12-12");}

      page.execute_script %Q{ $("#comparative_analysis_end_date").val("2012-12-12");}


      select_the_option(project,COMPARATIVE_PROJECT_DROPDOWN)
      clickButton(COMPARATIVE_PLOT_BUTTON)
      verify_if_visualization_is_displayed(COMPARATIVE_GRAPH_ID)
    end

    def verify_if_date_range_is_displayed(sdate, edate)
      assert page_has_content?('From '+sdate+' to '+edate),"No Date Displayed"
    end

    def verify_if_visualization_is_displayed(element)
      assert page_has_css?(element),"Nil"
    end

  end
end

World(Page::Comparative_Page)