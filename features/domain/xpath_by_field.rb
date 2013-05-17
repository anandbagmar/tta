module Domain  
  module XPathByField

  	@current_page = nil

	def get_xpath_by_field (pagename , fieldname)		 
		assign_page(pagename)
		get_xpath_from_current_page(fieldname)
	end	
	 
	def get_xpath_from_current_page(fieldname)		 
		@current_page[fieldname]
	end

	def assign_page(pagename)		 

         
    	case pagename
    	
    	when  "DEFECT ANALYSIS"
    		defect_analysis_page = Hash.new
    		defect_analysis_page["Sub-Project"] = "//label[@for='sub_project_id']"
    		defect_analysis_page["Analysis Date"] = "//label[@for='defect_analysis_analysis_date']"
    		@current_page = defect_analysis_page
            
    	when "PYRAMID VIEW"
    		pyramid_view_page = Hash.new
    		pyramid_view_page["Sub-Project"] = "//label[@for='sub_project_id']"    		
    		@current_page = pyramid_view_page

    	when "COMPARATIVE ANALYSIS"    		
    		comparative_analysis_page = Hash.new
    		comparative_analysis_page["Start Date"] = "//label[@for='comparative_analysis_start_date']"
    		comparative_analysis_page["End Date"] = "//label[@for='comparative_analysis_end_date']"
    		comparative_analysis_page["Project"] = "//label[@for='project_id']"
    		@current_page = comparative_analysis_page

        when "COMPARE RUNS"
            compare_runs_page = Hash.new
            compare_runs_page["Project"] = "//label[@for='project_select']"
            compare_runs_page["Sub-Project"] = "//label[@for='sub_project_select']"
            compare_runs_page["Date 1"] = "//label[@for='date_one_select']"
            compare_runs_page["Date 2"] = "//label[@for='date_two_select']"
            compare_runs_page["Test Types"] = "//label[@for='test_types_select']"
            @current_page = compare_runs_page
    	end
    		

    	 
	end
  end
end

World(Domain::XPathByField)