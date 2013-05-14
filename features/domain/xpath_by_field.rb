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
		 defect_analysis_page = Hash.new
    	 defect_analysis_page["Sub-Project"] =  "//label[@for='sub_project_id']"
    	 defect_analysis_page["Analysis Date"] =  "//label[@for='defect_analysis_analysis_date']"

		if (pagename == "DEFECT_ANALYSIS") then			 
			@current_page = defect_analysis_page			 
		end
	end
  end
end

World(Domain::XPathByField)