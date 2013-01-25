
Given /^The User uploads data with following attributes$/ do |table|
  # table is a |Project1|SubProj1|Run unit test|Mac    |Sailee   |IE     |DEV        |2012-01-01       |/var/lib/go-agent/pipelines/Development/tta_spec_results.zip |Unit Test       |pending
  upload_the_data(table)
end