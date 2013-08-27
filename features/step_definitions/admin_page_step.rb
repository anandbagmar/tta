When /^a team member visits Admin Page$/ do
  navigate_to_admin_page()
end

Then /^all project's information is generated in tabular format$/ do
  verify_project_information_display()
end
