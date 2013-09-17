require File.expand_path("spec/helpers/datahelper.rb")

module Domain
  module CompareRun
    def view_compare_run(project, sub_project, test_type, date1, date2)
      navigate_to_homepage()
      go_to_url(COMPARE_RUNS_PAGE)
      view_compare_run_data(project, sub_project, test_type, date1, date2)
    end

    def verify_if_compare_run_table_is_plotted(sub_project, date1, date2)
      wait_until_for { page.has_css?(COMPARE_RUN_TABLE_ID) }
      assert page.has_css?(COMPARE_RUN_TABLE_ID), "Compare run table is displayed"
    end

    def verify_if_message_is_displayed(date1, date2)
      wait_until_for { page.has_content?('TEST-CASES FAILING ON BOTH '+date1+' AND '+date2) }
      assert page.has_content?('TEST-CASES FAILING ON BOTH '+date1+' AND '+date2), "nil"
    end

    def perform_common_setup
      @jan_1_2013 ="2013-01-01 00:00:00 UTC"
      @jan_2_2013 ="2013-01-02 00:00:00 UTC"
      @unit_tests = "UNIT TESTS"
    end

    def create_test_suites
      @metadata1 = create_metadatum(@sub_project , @jan_1_2013 , @unit_tests)
      @metadata2 = create_metadatum(@sub_project , @jan_2_2013 , @unit_tests)
      @suite1 = create_suite_with_metadata(@metadata1 , "suite001")
      @suite2 = create_suite_with_metadata(@metadata2 , "suite002")
    end

    def create_new_project_and_subproject
      @project = create_project("COMPARE_RUNS_PROJECT")
      @sub_project = create_subproject_for_project(@project,"COMPARE_RUNS_SUBPROJECT")
    end

    def create_new_project_and_subproject
      @project = create_project("COMPARE_RUNS_PROJECT")
      @sub_project = create_subproject_for_project(@project,"COMPARE_RUNS_SUBPROJECT")
    end

    def create_class_errors(arg_suite, arr_class_names)
      arr_class_names.each do|class_name|
        add_failed_tests_from_suite(arg_suite,class_name,"error_msg_for#{class_name}")
      end
    end

    def extract_table_and_create_class_errors(table)
      day1=[]
      day2=[]
      table_data = table.hashes

      table_data.each do |hash|
        day1 << hash["day1"] unless  hash["day1"] == "" or hash["day1"] == "none"
        day2 << hash["day2"] unless  hash["day2"] == "" or hash["day2"] == "none"
      end

      create_class_errors(@suite1,day1)
      create_class_errors(@suite2,day2)
    end

    def verify_error_classes(table)

      day1 = []
      day2 = []
      combined = []
      common= []

      table_data = table.hashes

      table_data.each do |hash|
        day1 << hash["day1"] unless hash["day1"] == "" or hash["day1"] == "none"
        day2 << hash["day2"] unless hash["day2"] == ""  or hash["day2"] == "none"
        combined << hash["combined"] unless  hash["combined"] == "" or hash["combined"] == "none"
        common << hash["common"] unless  hash["common"] == "" or hash["common"] == "none"
      end

      verify_table_contains_error_classes("result_table_date1",day1)
      verify_table_contains_error_classes("result_table_date2",day2)
      verify_table_contains_error_classes("result_table_common",common)
      verify_table_contains_error_classes("result_table_both",combined)

    end

    def verify_table_contains_error_classes(table_name , arr_error_classes)
      actual_classes = get_classnames_listed_for_table(table_name)
             
      arr_error_classes.each do |error_class|
        assert_includes actual_classes , error_class
      end
    end
    
  end
end

module DataHelper
  def clean_up_data
    delete_project_and_associated_records "COMPARE_RUNS_PROJECT"
  end

  def delete_project_and_associated_records(project_name)
    projects = Project.find_all_by_name(project_name)
    projects.each do |project|
      subprojects = SubProject.find_all_by_project_id project.id
      delete_sub_projects_and_associated_records subprojects
      project.delete
    end
  end

  def delete_sub_projects_and_associated_records(subprojects)
    subprojects.each do |subproject|
      metadata = TestMetadatum.find_all_by_sub_project_id subproject.id
      delete_metadata_and_associated_records  metadata
      subproject.delete
    end
  end

  def delete_metadata_and_associated_records(test_metadata)
    test_metadata.each do |test_metadatum|
      test_suites = TestSuiteRecord.find_all_by_test_metadatum_id test_metadatum.id
      delete_test_suites_and_associated_records test_suites
      test_metadatum.delete
    end
  end

  def delete_test_suites_and_associated_records(test_suites)
    test_suites.each do |test_suite|
      test_case_records = TestCaseRecord.find_all_by_test_suite_record_id test_suite.id
      delete_test_case_records test_case_records
      test_suite.delete
    end
  end

  def delete_test_case_records(test_case_records)
    test_case_records.each do |test_case_record|
      test_case_record.delete
    end
  end
end

World(Domain::CompareRun)
World(DataHelper)