#
#When /^The User uploads data with following attributes$/ do |table|
#  # table is a |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-01-01       |/var/lib/go-agent/pipelines/Development/tta_spec_results.zip |Unit Test       |pending
#    table.hashes.each do |row|
#    upload_data(row)
#  end
#end
When /^the user checks Pyramimd View of "([^"]*)"$/ do |sub_proj|
  view_pyramid_view(sub_proj)
end

Then /^the test Pyramid for "([^"]*)" is generated with layers of pyramid equal to legends displayed$/ do |sub_proj|
  verify_pyramid_display(sub_proj)
end
