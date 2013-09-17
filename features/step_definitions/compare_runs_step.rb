When /^a team member checks compare runs of "(.*?)" "(.*?)" "(.*?)" with Date as "(.*?)" and "(.*?)"$/ do |project, sub_project, test_type, date1, date2|
  view_compare_run(project, sub_project, test_type, date1, date2)
end

Then /^the compare runs for "(.*?)" is plotted for Date "(.*?)" and "(.*?)"$/ do |sub_project, date1, date2|
  verify_if_compare_run_table_is_plotted(sub_project, date1, date2)
  verify_if_message_is_displayed(date1, date2)
end

Given(/^the following failure pattern$/) do |table|  
  clean_up_data
  perform_common_setup
  create_new_project_and_subproject
  create_test_suites
  extract_table_and_create_class_errors(table)
end

When(/^I compare the runs$/) do 
  navigate_to_homepage()
  go_to_url(COMPARE_RUNS_PAGE)  
  page.driver.browser.manage.window.maximize
  view_compare_run_data(
    "COMPARE_RUNS_PROJECT",
    "COMPARE_RUNS_SUBPROJECT",
    "UNIT TESTS",
    @jan_1_2013.sub(" UTC",""),
    @jan_2_2013.sub(" UTC",""))
end

Then(/^I see the following failures listed$/) do |table|
  verify_error_classes(table)
end