
Given /^That the user visits the url "([^"]*)"$/ do |our_url|
  visit our_url
  sleep(2)
end

Given /^The user navigates to "([^"]*)" page$/ do |page|
  click_button(page)
end

Then /^The user submits project details with "([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)","([^"]*)"$/ do |proj, sproj, ci, os, host, browser, env, exec_date, logDir, test_category|
  form_filling(proj,sproj,ci,os,host,browser,env,exec_date,logDir,test_category)
  sleep(2)
end

Then /^The project is uploaded$/ do
  page.has_css?("h2#notice",:visible =>true)
  click_button("HOME")
end

When /^"([^"]*)" is selected$/ do |arg|
  select arg , :from => "sub_project_id"
  click_button("Plot")
end

Then /^the test Pyramid is generated$/ do
  assert page.has_css?("#pyramid")
end

When /^The user enters Date Range between "([^"]*)" and "([^"]*)" for "([^"]*)"$/ do |startDate, endDate, proj|
  fill_in "comparative_analysis_start_date" ,:with => startDate
  fill_in "comparative_analysis_end_date" , :with => endDate
  select proj, :from => "project_id"
  click_button("Plot")
end

Then /^The graph is plotted$/ do
  assert page.has_css?("#comparative_analysis")
end

