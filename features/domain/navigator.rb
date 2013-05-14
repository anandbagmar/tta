module Domain
  module Navigator
    def navigate_to_homepage()
      visit HOMEPAGE
    end

   def navigate_to_page (pagename)
      case pagename
      when "DEFECT_ANALYSIS"
        visit "/defect_analysis"
      end
    end
    
 

  end
end

World(Domain::Navigator)