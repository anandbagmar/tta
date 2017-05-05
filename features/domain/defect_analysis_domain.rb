module Domain
  module DefectAnalysis
    def view_defect_analysis_graph(product, platform, testcategory)
      navigate_to_homepage()
      go_to_url(DEFECT_PAGE)
      view_defect_graph(product, platform, testcategory)
    end

    def verify_defect_graph_plotted(platform_name)
      assert page.has_content?("PLATFORM : "+platform_name)
      assert page.has_css?(DEFECT_GRAPH_ID)
    end
  end
end

World(Domain::DefectAnalysis)