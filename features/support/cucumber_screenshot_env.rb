require 'fileutils'
module Support
  module Cucumber_Screenshot
    def random_name(size = 8)
      chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
      (1..size).collect { |a| chars[rand(chars.size)] }.join
    end

    def save_error_screenshot(file_name)
      if !Dir.exist?(SCREENSHOT_FILE_PATH)
        FileUtils::mkdir_p SCREENSHOT_FILE_PATH
      end
      File.open(file_name, 'wb') do |f|
        f.write(Base64.decode64(page.driver.browser.screenshot_as(:base64)))
      end
    end
  end
end

World(Support::Cucumber_Screenshot)
