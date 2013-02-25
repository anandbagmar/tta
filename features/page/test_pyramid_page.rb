module Page
  module Test_pyramid_Page

    def fill_pyramid_data(sub_proj)
       select_the_option(sub_proj,TEST_PYRAMID__PROJECT_DROPDOWN)
       click_button(TEST_PYRAMID_PAGE_BUTTON)
    end
    def verify_if_legends_is_equal_to_divisions
      no_of_legend = page.all(:xpath,"//div[@id='legend']/div").length
      no_of_pyramid_divisions =  page.all(:xpath,"//div[@id='pyramid']/div").length
      verify_data = no_of_legend == no_of_pyramid_divisions
      verify_data
    end

  end
end


World(Page::Test_pyramid_Page)



