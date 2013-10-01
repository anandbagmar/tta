module Domain
  module CompareRun
    def view_compare_run(project, sub_project, test_type, date1, date2)
      navigate_to_homepage()
      go_to_url(COMPARE_RUNS_PAGE)
      view_compare_run_data(project, sub_project, test_type, date1, date2)
    end

    def verify_if_compare_run_table_is_plotted(sub_project, date1, date2)
      assert page.has_css?(COMPARE_RUN_TABLE_ID), "Compare run table is displayed"
    end

    def verify_if_message_is_displayed(date1, date2)
      assert page.has_content?('TEST-CASES FAILING ON BOTH '+date1+' AND '+date2), "nil"
    end

  end
end

World(Domain::CompareRun)