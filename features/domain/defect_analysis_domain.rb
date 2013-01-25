module Domain
  module DefectDomain

    def view_defect_analysis_graph(subproject_name, date)
      navigate_to_defect()
      fill_defect_form_info(subproject_name,date)
    end

    def fill_defect_form_info(subproject_name,date)
      view_defect_graph(subproject_name,date)
    end

    def verify_defect_graph_plotted(subproject_name)
      verify_defect_graph(subproject_name)
    end

    def navigate_to_defect
      navigate_to_homepage()
      navigate_to_defect_page()
    end

    def navigate_to_defect_page
      go_to_url(DEFECT_PAGE)
    end

  end
end


World(Domain::DefectDomain)