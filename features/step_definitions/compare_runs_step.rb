When /^a team member checks compare runs of "(.*?)" "(.*?)" "(.*?)" with Date as "(.*?)" and "(.*?)"$/ do |project, sub_project, test_type, date1, date2|
  view_compare_run(project, sub_project, test_type, date1, date2)
end

Then /^the compare runs for "(.*?)" is plotted for Date "(.*?)" and "(.*?)"$/ do |sub_project, date1, date2|
  verify_if_compare_run_table_is_plotted(sub_project, date1, date2)
  verify_if_message_is_displayed(date1, date2)
end