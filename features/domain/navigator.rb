module Domain
  module Navigator
    def navigate_to_homepage()
      visit HOMEPAGE
      page.driver.browser.manage.window.maximize
    end
  end
end

World(Domain::Navigator)