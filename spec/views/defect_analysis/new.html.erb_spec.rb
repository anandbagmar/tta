require 'spec_helper'

module  DefectAnalysisTestHelper

	def display_this_field_is_required
		have_content 'This field is required.'
	end

	def click_plot_button
		click_button "Plot"		
	end

	def select_sub_project
		find("option[value='1']").click
	end

	def specify_date
		page.execute_script("$('#defect_analysis_analysis_date').val('2013-01-01')")		
	end

	def visit_page
		visit '/defect_analysis'
	end
		
	def get_xpath_for_label (label_name)
		case label_name.upcase.gsub(" ","")		
		when  'SUBPROJECTID'
			xpath_expression = "//label[@for='sub_project_id']"			
		when 'ANALYSISDATE'
			xpath_expression = "//label[@for='defect_analysis_analysis_date']"
		end 
	end

	def label_for(label_name)	
		find :xpath , get_xpath_for_label(label_name) 
	end

	def have_error_for_label (label_name)
		have_xpath get_xpath_for_label(label_name) 
	end

	def error_message_for ( label_name , is_error_message_expected)		
		if (is_error_message_expected) then
			label_for(label_name).should  display_this_field_is_required
		else
			page.should_not	have_error_for_label(label_name)
		end
	end


end

describe "Defect Analysis Page" , js: true do

	include DefectAnalysisTestHelper

	before { visit_page }
	subject { page }
	let(:should_be_displayed ) { true}
	let(:should_not_be_displayed) {false}

	it "should display error when Sub-project and Date is not specified"  do			 			 	 
		click_plot_button		
		error_message_for 'Sub Project Id' , should_be_displayed
		error_message_for 'Analysis Date' , should_be_displayed		
  	end 

	it "should display error when Sub-project is specified and Date is not Specified" do	
		select_sub_project
		click_plot_button		 			 				  		 
		error_message_for 'Sub Project Id' , should_not_be_displayed
		error_message_for 'Analysis Date' , should_be_displayed
	end

	it "should display error when Sub-project is not specified and Date is Specified" do		
		specify_date
		click_plot_button		
		error_message_for 'Sub Project Id' , should_be_displayed
		error_message_for 'Analysis Date' , should_not_be_displayed 
	end

	it "should not display error when Sub-project and Date are Specified" do		
		select_sub_project		
		specify_date
		click_plot_button
		error_message_for 'Sub Project Id' , should_not_be_displayed 
		error_message_for 'Analysis Date' , should_not_be_displayed 
	end
end