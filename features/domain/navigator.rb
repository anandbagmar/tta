module Domain
  module Navigator
    def navigate_to_homepage()
      visit HOMEPAGE
    end

   def navigate_to_page (pagename)
      case pagename
        when "DEFECT ANALYSIS"
          visit "/defect_analysis"
        when "PYRAMID VIEW"
          visit "/pyramid"
        when "COMPARATIVE ANALYSIS"
          visit "/comparative_analysis"
        when "COMPARE RUNS"
          visit "/compare_runs"
      end
    end
    
 

  end
end

World(Domain::Navigator)