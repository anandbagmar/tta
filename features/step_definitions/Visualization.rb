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

Then /^"([^"]*)" is selected and the test Pyramid is generated$/ do |spid|
  select spid , :from => "sub_project_id"
  click_button("Plot")
  sleep(10)
  assert page.has_css?("#pyramid")
end

Then /^The user enters Date Range between "([^"]*)" and "([^"]*)" for "([^"]*)" and the graph is plotted$/ do |sdate, edate, pid|
  fill_in "comparative_analysis_start_date" ,:with => sdate
  fill_in "comparative_analysis_end_date" , :with => edate
  select pid, :from => "project_id"
  click_button("Plot")
  sleep(10)
  assert page.has_css?("#comparative_analysis")
end






