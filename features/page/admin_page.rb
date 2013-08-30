module Page
  module AdminPage
    def navigate_to_admin_statistics_page()
      visit ADMIN_STATS_PAGE
    end
  end
end

World(Page::AdminPage)



