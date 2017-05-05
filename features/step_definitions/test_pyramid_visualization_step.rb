When /^a team member checks Pyramid View of "([^"]*)"$/ do |platform|
  view_pyramid_view(platform)
end

Then /^the test Pyramid for "([^"]*)" is generated$/ do |platform|
  verify_pyramid_display(platform)
end

Then /^the Pyramid table for "([^"]*)" is generated$/ do |platform|
  verify_pyramid_table_display(platform)
end