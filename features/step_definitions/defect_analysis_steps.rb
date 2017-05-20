When /^a team member checks Defect Analysis Graph of Product "([^"]*)" and Platform "([^"]*)" with test category as "([^"]*)" and Date as "([^"]*)"$/ do |product, platform, test_category, date|
  view_defect_analysis_graph(product, platform, test_category, date)
end

Then /^the Defect Analysis table for "([^"]*)" is plotted$/ do |platform_name|
  verify_defect_graph_plotted(platform_name)
end
