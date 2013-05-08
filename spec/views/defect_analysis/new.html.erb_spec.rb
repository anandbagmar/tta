require 'spec_helper'

describe 'Defect Analysis Page' , js: true do		
	
	it 'should display error when Sub-project and Date is not specified' do
		visit  '/defect_analysis'
		click_button "Plot"		
		
		# error label for sub_project_id should display error
		find(:xpath , "//label[@for='sub_project_id']").should have_content 'This field is required.'

		# error label for date should display error
		find(:xpath , "//label[@for='defect_analysis_analysis_date']").should have_content 'This field is required.'
	end 

	it "should display error when Sub-project is specified and Date is not Specified" do	
		
		visit  '/defect_analysis'
		find("option[value='1']").click
		
		click_button "Plot"		
		
		# error label for sub_project_id should not display error		
		page.should_not have_xpath("//label[@for='sub_project_id']")

		# error label for date should display error
		find(:xpath , "//label[@for='defect_analysis_analysis_date']").should have_content 'This field is required.'
	end

	it "should display error when Sub-project is not specified and Date is Specified" do		
		
		visit  '/defect_analysis'		
		page.execute_script("$('#defect_analysis_analysis_date').val('2013-01-01')")
		
		click_button "Plot"		
		
		#error label for sub_project_id should not display error		
		find(:xpath , "//label[@for='sub_project_id']").should have_content 'This field is required.'

		#error label for date should display error
		#find(:xpath , "//label[@for='defect_analysis_analysis_date']").should have_content 'This field is required.'
		page.should_not have_xpath("//label[@for='defect_analysis_analysis_date']")
	end

	it "should not display error when Sub-project and Date are Specified" do		
		
		visit  '/defect_analysis'		
		find("option[value='1']").click
		page.execute_script("$('#defect_analysis_analysis_date').val('2013-01-01')")
		click_button "Plot"		
		
		#error label for sub_project_id should not display error		
		page.should_not have_xpath("//label[@for='sub_project_id']")

		#error label for date should display error		
		page.should_not have_xpath("//label[@for='defect_analysis_analysis_date']")
	end
end
