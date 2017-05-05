When /^a team member visits Admin Statistics Page$/ do
  navigate_to_admin_statistics_page()
end

Then /^all product information is generated in tabular format$/ do
  verify_product_information_display()
end
