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
      assert page_has_content?(proj_succ),"No Project uploaded"
    end


    def upload_data(proj_params)
      form_filling(proj_params[:proj],proj_params[:sub_proj],proj_params[:ci_job],proj_params[:osName],proj_params[:hostName],proj_params[:browser],proj_params[:environment],proj_params[:dateOfExecution],proj_params[:logDir],proj_params[:test_type])
    end

    def view_graph(project, start_date, end_date)

      page.execute_script %Q{ $("#comparative_analysis_start_date").val("1990-12-12");}
      sleep(5)
      page.execute_script %Q{ $("#comparative_analysis_end_date").val("2012-12-12");}
      sleep(5)

      select_the_option(project,COMPARATIVE_PROJECT_DROPDOWN)
      clickButton(COMPARATIVE_PLOT_BUTTON)
      verify_graph_plotted(start_date,end_date,project)
    end

    def verify_graph_plotted(start_date,end_date,project)
      verify_if_date_range_is_displayed(start_date,end_date)
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