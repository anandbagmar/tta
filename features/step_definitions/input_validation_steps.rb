Given(/^a user is on the "(.*?)" page$/) do |user_page|
	navigate_to_page user_page   
  	@user_page = user_page
end

When(/^the user clicks the "(.*?)" button$/) do |button|	
	click_button button	 
end
 
When(/^the user specifies a Subproject$/) do   
	if (@user_page == "DEFECT_ANALYSIS") then		 	
		find("option[value='1']").click
  	end
end

When(/^the user specifies an Analysis Date$/) do
  	time = Time.new
  	time_str = "#{time.year}-#{time.month}-#{time.day}"  
  	page.execute_script("$('#defect_analysis_analysis_date').val('" + time_str +"')")
end

Then(/^the user should see the message$/) do |table|
	table.hashes.each do |message_field_pair|   		 		 
   		 field = get_xpath_by_field(@user_page , message_field_pair["field"])
    	 message =  message_field_pair["message"]
    	 find(:xpath , field).should have_content message	     
   	end 
end

Then(/^the user should not see the message$/) do |table|  
	table.hashes.each do |message_field_pair|		
		field = get_xpath_by_field(@user_page , message_field_pair["field"])		
		begin
			label_element = find(:xpath , field)		
			if (!label_element.nil?) then			
				label_element.should_not have_content message_field_pair["field"]
			end
		rescue Capybara::ElementNotFound
		end
  	end
end
