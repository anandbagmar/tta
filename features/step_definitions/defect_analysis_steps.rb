When /^a team member checks Defect Analysis Graph of Project "([^"]*)" and Sub-Project "([^"]*)" with test category as "([^"]*)" and Date as "([^"]*)"$/ do |project, subproject, testcategory, date|
  view_defect_analysis_graph(project, subproject, testcategory)
end

Then /^the Defect Analysis table for "([^"]*)" is plotted$/ do |subproject_name|
  verify_defect_graph_plotted(subproject_name)
end
