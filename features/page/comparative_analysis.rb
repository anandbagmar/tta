module Page
  module ComparativeAnalysis
    def view_graph(project, sub_project,start_date, end_date)
      page.execute_script %Q{ $("#comparative_analysis_start_date").val("2011-12-12");}
      page.execute_script %Q{ $("#comparative_analysis_end_date").val("2012-12-12");}

      select_the_option(project, COMPARATIVE_PROJECT_DROPDOWN)
      select_the_option(sub_project, COMPARATIVE_SUB_PROJECT_DROPDOWN)
      scroll_to_view_and_click_on(COMPARATIVE_PLOT_BUTTON)
    end
  end
end

World(Page::ComparativeAnalysis)