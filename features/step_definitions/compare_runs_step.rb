When /^a team member checks compare runs of "(.*?)" "(.*?)" "(.*?)" with Date as "(.*?)" and "(.*?)"$/ do |product, platform, test_type, date1, date2|
  view_compare_run(product, platform, test_type, date1, date2)
end

Then /^the compare runs for "(.*?)" is plotted for Date "(.*?)" and "(.*?)"$/ do |platform, date1, date2|
  verify_if_compare_run_table_is_plotted(platform, date1, date2)
  verify_if_message_is_displayed(date1, date2)
end