Given /^That the User is on the "([^"]*)"$/ do |page_name|
  navigate_to_homepage()
  navigate_to_page(page_name)
end

When /^The User clicks on the "([^"]*)"$/ do |button_name|

  clickButton(button_name)
end

Then /^Appropriate Error for the "([^"]*)" should be displayed$/ do  |page_name|
  verify_error_is_displayed(page_name)
end
