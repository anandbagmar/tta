Given(/^a user is on the "(.*?)" page$/) do |user_page|
	navigate_to_page user_page   
  	@user_page = user_page
end
 
Given(/^the user specifies a Subproject$/) do
	
	if (@user_page == "DEFECT ANALYSIS" )then		 	
		find("option[value='1']").click
	elsif (@user_page == "COMPARE RUNS") then
		find("option[class='sub-element'][value='1']").click
  	end
end

Given(/^the user specifies a Project$/) do
	
	if (@user_page == "COMPARATIVE ANALYSIS" ) then		 	
		find("option[value='1']").click
	elsif (@user_page == "COMPARE RUNS") then
		find("option[class='proj-element'][value='1']").click
  	end  

end

Given(/^the user specifies a Test Category$/) do
  find("option[class='test-element']").click
end



#Given(/^the user specifies an Analysis Date$/) do
#  	time = Time.new
#  	time_str = "#{time.year}-#{time.month}-#{time.day}"    	
#end

Given(/^the user specifies the date \-  "(.*?)"$/) do |user_date|
  time = Time.new
  	time_str = "#{time.year}-#{time.month}-#{time.day}"

  	if (@user_page == "DEFECT ANALYSIS") then
  		page.execute_script("$('#defect_analysis_analysis_date').val('" + time_str +"')")
	end

	if (@user_page == "COMPARATIVE ANALYSIS") then

		if (user_date == "Start Date") then
			page.execute_script("$('#comparative_analysis_start_date').val('" + time_str +"')")
		end

		if (user_date == "End Date") then
			page.execute_script("$('#comparative_analysis_end_date').val('" + time_str +"')")
		end
	end

	if(@user_page == "COMPARE RUNS")  then
		if(user_date == "Date 1") then
			find("option[class='compare_date_one'][id='date_one_1']").click
		else
			find("option[class='compare_date_two'][id='date_two_2']").click
		end 
	end

end

When(/^the user waits$/) do
  sleep (10)
end


When(/^the user clicks the "(.*?)" button$/) do |button|			
	if (@user_page == "COMPARATIVE ANALYSIS" and button == "Submit") then
		find(:xpath , "//input[@id='form-submit']").click		
	elsif (@user_page == "COMPARE RUNS" and button == "Submit") then
		find(:xpath , "//input[@id='compare_runs']").click
	else
		click_button button		 
	end  	
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