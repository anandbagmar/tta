module Page
  module Test_pyramid_Page


    def fill_pyramid_data(sub_proj)
       select_data(sub_proj)
       plot_pyramid()
    end

    def verify_display (subproject)
      verify_if_pyramid_is_displayed()
      verify_if_title_is_displayed(subproject)
      verify_if_legends_is_equal_to_divisions()
    end

    def plot_pyramid
      clickButton(TEST_PYRAMID_PAGE_BUTTON)
    end

    def select_data(sub_proj)
      select_the_option(sub_proj,TEST_PYRAMID__PROJECT_DROPDOWN)
    end

    def go_to_url(button)
      clickButton(button)
    end


    def verify_if_pyramid_is_displayed()
      assert page_has_css?(PYRAMID_ID),"Pyramid is displayed"
    end

    def verify_if_title_is_displayed(title)
      assert page_has_content?("Test-Pyramid for: "+title),"Title not displayed"
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



