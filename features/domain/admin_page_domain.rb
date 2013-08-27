module Domain
  module AdminPage
    def verify_project_information_display()
      assert page.has_content? ("PROJECT NAME")
    end
  end
end

World(Domain::AdminPage)