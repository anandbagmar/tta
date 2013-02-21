module Domain
  module DefectDomain

    def view_defect_analysis_graph(subproject_name, date)
      navigate_to_homepage()
      go_to_url(DEFECT_PAGE)
      view_defect_graph(subproject_name,date)
    end

    def verify_defect_graph_plotted(subproject_name)
      assert page_has_content?("Sub Project:"+subproject_name)
      assert page_has_css?(DEFECT_GRAPH_ID)
    end

  end
end


World(Domain::DefectDomain)