When /^a team member visits Admin Statistics Page$/ do
  navigate_to_admin_statistics_page()
end

Then /^all project's information is generated in tabular format$/ do
  verify_project_information_display()
end
