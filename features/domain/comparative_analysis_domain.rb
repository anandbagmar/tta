module Domain
  module ComparativeAnalysis
    def view_comparative_graph(product, platform, start_date, end_date)
      navigate_to_homepage()
      go_to_url(COMPARATIVE_PAGE)
      view_graph(product, platform, start_date, end_date)
    end

    def verify_if_date_range_is_displayed(sdate, edate)
      page.should have_content('From '+sdate+' to '+edate)
    end

    def verify_if_visualization_is_displayed(element)
      assert page.has_css?(element), "Nil"
    end
  end
end

World(Domain::ComparativeAnalysis)