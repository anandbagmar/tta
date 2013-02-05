module Page
  module Test_pyramid_Page


    def fill_pyramid_data(sub_proj)
       select_the_option(sub_proj,TEST_PYRAMID__PROJECT_DROPDOWN)
       clickButton(TEST_PYRAMID_PAGE_BUTTON)
    end

    def verify_display (subproject)
      assert page_has_css?(PYRAMID_ID),"Pyramid is displayed"
      assert page_has_content?("Test-Pyramid for: "+subproject),"Title not displayed"
      verify_if_legends_is_equal_to_divisions()
    end

    def go_to_url(button)
      clickButton(button)
    end

    def verify_if_legends_is_equal_to_divisions
      no_of_legend = page.all(:xpath,"//div[@id='legend']/div").length
      sleep(5)
      no_of_pyramid_divisions =  page.all(:xpath,"//div[@id='pyramid']/div").length
      sleep(5)
      assert(no_of_legend == no_of_pyramid_divisions,"label and divisions not equal")
    end
  end
end


World(Page::Test_pyramid_Page)



