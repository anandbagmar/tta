module Page
  module TestPyramid
    def fill_pyramid_data(sub_proj)
      select_the_option(sub_proj, TEST_PYRAMID__PROJECT_DROPDOWN)
      click_button(TEST_PYRAMID_PAGE_BUTTON)
    end

    def verify_if_no_of_rows_equals_no_of_blocks_in_pyramid
      no_of_rows = page.all(:xpath, "//table/tbody/tr").length-1
      no_of_pyramid_divisions = page.all(:xpath, "//div[@id='pyramid']/div").length
      verify_data = no_of_rows == no_of_pyramid_divisions
      verify_data
    end
  end
end

World(Page::TestPyramid)



