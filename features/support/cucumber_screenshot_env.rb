module Support
module Cucumber_Screenshot

  def random_password(size = 8)
    chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
    (1..size).collect{|a| chars[rand(chars.size)] }.join
  end

  def save_error_screenshot(file_name)
    File.open(file_name, 'wb') do |f|
    f.write(Base64.decode64(page.driver.browser.screenshot_as(:base64)))
    end
  end


  #After do |scenario|
  #  if scenario.failed?
  #     file_name = SCREENSHOT_FILE_PATH+"screenshot_"+random_password+".png"
  #     save_error_screenshot(file_name)
  #  end
  #end


#  AfterStep('@screenshot') do |scenario|
#    if screenshot_due?
#      screenshot
#    end
#  end
#rescue Exception => e
#  puts "Snapshots not available for this environment. Try installing
#cucumber-screenshot with\n\n  gem install cucumber-screenshot\n"
end
end

  World(Support::Cucumber_Screenshot)
