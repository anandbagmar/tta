
When /^a team member checks Pyramid View of "([^"]*)"$/ do |sub_proj|
  view_pyramid_view(sub_proj)
end


Then /^the test Pyramid for "([^"]*)" is generated$/ do |sub_proj|
  verify_pyramid_display(sub_proj)
end

Then /^the Pyramid table for "([^"]*)" is generated$/ do |sub_proj|
  verify_pyramid_table_display(sub_proj)
end