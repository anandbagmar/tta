Given /^that The user is on the homepage$/ do
  visit "http://172.18.6.1:3000"
  sleep(30)
end
When /^The user wants to upload the project details$/ do
  click_button("UPLOAD TEST DATA")
  #visit "http://www.google.com"



    #visit "http://google.com"
    #p page.html
    #fill_in "gbqfq", :with => "Agile Samurai author name"
    #click_button "gbqfsa"
    #
    #should have_content "Jonathan Rasmusson"




  #sleep(10)
  #p page.has_css?("#lga",:exists=>true)
 #p find(:xpath,"//title").text
end
Then /^The user is on Upload page$/ do
  sleep(30)
  #p page.has_css?("#uploadForm")

  #page.has_css?("div.heading>h1",:visible=>true)
  #page.has_content?(" Project Name ")
  #find("div.heading>h1")
  fill_in 'project_name' , :with => "Project1"
  #click_button("reset_button")
  #click_button "COMPARATIVE ANALYSIS"
  #click_button("UPLOAD TEST DATA")
  #assert page.has_css?("#reset_button",:visible=>true)
  #click_button("")
  #find("#reset_button").click
end
