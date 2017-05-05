module Page
  module CompareRun
    def view_compare_run_data(product, platform, test_type, date1, date2)
      select_the_option(product, COMPARATIVE_PRODUCT_DROPDOWN)
      select_the_option(platform, COMPARE_RUN_PLATFORM_DROPDOWN)
      select_the_option(test_type, COMPARE_RUN_TEST_TYPE_DROPDOWN)
      select_the_option(date1, COMPARE_RUN_TEST_DATE1)
      select_the_option(date2, COMPARE_RUN_TEST_DATE2)
      click_button(COMPARE_PAGE_BUTTON)
    end
  end
end

World(Page::CompareRun)