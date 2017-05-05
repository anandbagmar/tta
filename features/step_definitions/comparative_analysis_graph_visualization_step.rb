When /^a team member checks Comparative Analysis Graph of "(.*?)" and platform "(.*?)" with Date Range between "(.*?)" and "(.*?)"$/ do |product, platform, start_date, end_date|
  view_comparative_graph(product, platform, start_date, end_date)
end

Then /^the comparative analysis graph for "([^"]*)" is generated with Date Range between "([^"]*)" and "([^"]*)"$/ do |proj, sdate, edate|
  verify_if_date_range_is_displayed(sdate, edate)
  verify_if_visualization_is_displayed(COMPARATIVE_GRAPH_ID)
end
