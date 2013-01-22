Given /^That the user visits the url "([^"]*)"$/ do |our_url|
  visit our_url

end

Given /^The user navigates to "([^"]*)" page$/ do |page_name|
  sleep(10)
  click_button page_name
end

Then /^The user submits project details with "([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)"$/ do |proj, sproj, ci, os, host, browser, env, exec_date, logDir, test_category|
  form_filling(proj,sproj,ci,os,host,browser,env,exec_date,logDir,test_category)

end

Then /^The project is uploaded$/ do
  sleep(10)
  assert page.has_css?("h2#notice",:visible =>true)


end

Then /^error message should be displayed$/ do
  assert page.has_content?("No Sub-Project Selected")
end
Then /^error message for defect analysis should be displayed$/ do
  assert page.has_content?("No Sub-Project Selected")
  assert page.has_content?("No Date Selected")
end

When /^"([^"]*)" is selected$/ do |spid|
  select spid , :from => "sub_project_id"
end
Then /^the test Pyramid for "([^"]*)" is generated with layers of pyramid equal to legends displayed$/ do |sub_proj|
  click_button("Plot")
  sleep(10)
  assert page.has_css?("#pyramid")
  assert page.has_content?("Test-Pyramid for: "+sub_proj)
  no_of_legend = page.all(:xpath,"//div[@id='legend']/div").length
  sleep(5)
  no_of_pyramid_divisions =  page.all(:xpath,"//div[@id='pyramid']/div").length
  sleep(5)
  assert_equal no_of_legend ,no_of_pyramid_divisions
end

When /^The user enters Date Range between "([^"]*)" and "([^"]*)" for "([^"]*)"$/ do |sdate, edate, pid|
  fill_in "comparative_analysis_start_date" ,:with => sdate
  fill_in "comparative_analysis_end_date" , :with => edate
  select pid, :from => "project_id"
  click_button("Plot")
  sleep(10)

end



Then /^the graph is plotted with the "([^"]*)"$/ do |proj|
  assert page.has_css?("#comparative_analysis")
  #assert page.has_content?(proj)
end
When /^Start Date and End Date as "([^"]*)" and "([^"]*)" respectively$/ do |start_date, end_date|
  assert page.has_content?('From '+start_date+' to '+end_date)
end


When /^The User clicks on the "([^"]*)" button$/ do |button|
  click_button(button)
  sleep(10)
end


Then /^Error messages should be seen$/ do
  assert page.has_content?('Please Enter Start date')
  assert page.has_content?('Please Enter End date')
  assert page.has_content?('Please select a Project')
end
Then /^Appropriate Error Messages are displayed$/ do
  assert page.has_content?('This field is required.')
end