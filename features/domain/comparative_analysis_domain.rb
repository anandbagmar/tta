module Domain
  module ComparativeDomain
    def view_comparative_graph(project, start_date, end_date)
      navigate_to_homepage()
      go_to_url(COMPARATIVE_PAGE)
      view_graph(project, start_date, end_date)
    end

    def verify_if_date_range_is_displayed(sdate, edate)
      wait_until_for { page.has_content?('From '+sdate+' to '+edate) }
      assert page.has_content?('From '+sdate+' to '+edate)
    end

    def verify_if_visualization_is_displayed(element)
      wait_until_for { page.has_css?(element) }
      assert page.has_css?(element), "Nil"
    end
  end
end

World(Domain::ComparativeDomain)