module Domain
  module ComparativeDomain

    def navigate_to_upload_page
        go_to_url(UPLOAD_PAGE)
    end

    def go_to_url(button)
     clickButton(button)
    end

    def view_comparative_graph(project, start_date, end_date)
      navigate_to_homepage()
      go_to_url(COMPARATIVE_PAGE)
      view_graph(project,start_date,end_date)
    end

  end
end

World(Domain::ComparativeDomain)