module Page
  module Comparative_Page

    def fill_the_form(table)
      table.hashes.each do |row|
        navigate_to_homepage
        navigate_to_upload_page
        upload_data(row)
        submit_form()
        end
    end


    def submit_form()
      clickButton(UPLOAD_PAGE_BUTTON)
      verify_data_uploaded(UPLOAD_SUCCESS)
    end

    def verify_data_uploaded(proj_succ)
      page_has_content?(proj_succ)
    end


    def upload_data(proj_params)
      form_filling(proj_params[:proj],proj_params[:sub_proj],proj_params[:ci_job],proj_params[:osName],proj_params[:hostName],proj_params[:browser],proj_params[:environment],proj_params[:dateOfExecution],proj_params[:logDir],proj_params[:test_type])
    end

    def view_graph(project, start_date, end_date)
      fill_in_data(COMPARATIVE_START_DATE,start_date )
      fill_in_data(COMPARATIVE_END_DATE,end_date)
      select_the_option(project,COMPARATIVE_PROJECT_DROPDOWN)
      clickButton(COMPARATIVE_PLOT_BUTTON)
      verify_graph_plotted(start_date,end_date,project)
    end

    def verify_graph_plotted(start_date,end_date,project)
      verify_if_date_range_is_displayed(start_date,end_date)
      verify_if_visualization_is_displayed(COMPARATIVE_GRAPH_ID)
    end

    def verify_if_date_range_is_displayed(sdate, edate)
      page_has_content?('From '+sdate+' to '+edate)
    end

    def verify_if_visualization_is_displayed(element)
      page_has_css?(element)
    end

  end
end

World(Page::Comparative_Page)