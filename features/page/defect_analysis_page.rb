module Page
  module Defect_Page

    def view_defect_graph(subproject_name, date)
      fill_details(subproject_name,date)
      create_plot()
    end

    def fill_details(subproject_name, date)
      select_the_option(subproject_name,DEFECT_SUBPROJECT_DROPDOWN)
      fill_in_data(DEFECT_FORM_DATE,date)
    end


    def create_plot()
      clickButton(DEFECT_PAGE_BUTTON)
    end

    def go_to_url(button)
      clickButton(button)
    end


    def verify_defect_graph(subproject_name)
      page_has_content?("Sub Project:"+subproject_name)
      page_has_css?(DEFECT_GRAPH_ID)
    end
  end
end


World(Page::Defect_Page)