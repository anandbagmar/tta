module Page
  module Comparative_Page

    def view_graph(project, start_date, end_date)

      page.execute_script %Q{ $("#comparative_analysis_start_date").val("2011-12-12");}

      page.execute_script %Q{ $("#comparative_analysis_end_date").val("2012-12-12");}


      select_the_option(project,COMPARATIVE_PROJECT_DROPDOWN)
      click_button(COMPARATIVE_PLOT_BUTTON)
    end

   end
end

World(Page::Comparative_Page)