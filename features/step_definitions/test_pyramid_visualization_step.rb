
When /^the user checks Pyramid View of "([^"]*)"$/ do |sub_proj|
  view_pyramid_view(sub_proj)
end

Then /^the test Pyramid for "([^"]*)" is generated with layers of pyramid equal to legends displayed$/ do |sub_proj|
  verify_pyramid_display(sub_proj)
end


Then /^the appropriate error message is displayed for "(.*?)"$/ do |sub_proj|
  verify_error_msg(sub_proj)
end
