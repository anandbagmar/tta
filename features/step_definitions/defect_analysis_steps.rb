When /^a team member checks Defect Analysis Graph of "([^"]*)" with Date as "([^"]*)"$/ do |subproject_name, date|
  view_defect_analysis_graph(subproject_name, date)
end

Then /^the Defect Analysis table for "([^"]*)" is plotted$/ do |subproject_name|
  verify_defect_graph_plotted(subproject_name)
end
