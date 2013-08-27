module Page
  module AdminPage
    def navigate_to_admin_page()
      visit ADMIN_PAGE
    end
  end
end

World(Page::AdminPage)



