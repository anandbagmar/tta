module Page
  module CompareRun_Page

   def view_compare_run_data(project,sub_project,test_type,date1,date2)

      select_the_option(project,COMPARATIVE_PROJECT_DROPDOWN)
      select_the_option(sub_project,COMPARE_RUN_SUB_PROJECT_DROPDOWN)
      select_the_option(test_type,COMPARE_RUN_TEST_TYPE_DROPDOWN)
      select_the_option(date1,COMPARE_RUN_TEST_DATE1)
      select_the_option(date2,COMPARE_RUN_TEST_DATE2)
      click_button(COMPARE_PAGE_BUTTON)
     end

    end
end

World(Page::CompareRun_Page)