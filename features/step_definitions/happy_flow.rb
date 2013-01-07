require 'test/unit/assertions'
World(Test::Unit::Assertions)

Given /^That the user enters "([^"]*)"$/ do |our_url|
  visit our_url
end
Then /^"([^"]*)" homepage should be open$/ do |title|
  find('h1').should have_content(title)
end

Then /^(.*) page should open$/ do |page_title|
  find('#page_title>h1').should have_content(page_title)
end
Given /^The user navigates to "([^"]*)" page$/ do |arg|
  find_button(arg).click
end
When /^The user submits project details with "([^"]*)" as test type$/ do |test_type|
 form_filling(test_type)
end
Then /^"([^"]*)" page is shown and the user navigates back to "([^"]*)"$/ do |arg1, arg2|
  page.has_content?(arg1)
  find_button(arg2).click
end
When /^"([^"]*)" is selected$/ do |arg|
  select arg , :from => "sub_project_id"
  click_button("Plot")
end
Then /^the test Pyramid is generated$/ do
  assert page.has_css?("#pyramid")
end