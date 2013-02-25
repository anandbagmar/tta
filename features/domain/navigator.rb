
 module Domain
  module Navigator

    def navigate_to_homepage()
      visit HOMEPAGE
    end

  end
 end

 World(Domain::Navigator)