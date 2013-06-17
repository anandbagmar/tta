class CompareRuns

  def self.getCompareResult(form_data)
    sub_project_id=form_data["sub_projects"]
    test_category=form_data["test_types"]
    date_one = form_data["date_one"]
    date_two = form_data["date_two"]

    test_case_records_with_errors_for_date_one = get_test_suite_records_with_errors_for(date_one, sub_project_id, test_category)
    test_case_records_with_errors_for_date_two = get_test_suite_records_with_errors_for(date_two, sub_project_id, test_category)
    common_failures = test_case_records_with_errors_for_date_one & test_case_records_with_errors_for_date_two
    combined_total_failures = test_case_records_with_errors_for_date_one | test_case_records_with_errors_for_date_two

    failure_comparison = {}
    failure_comparison[:common_failures] = common_failures unless common_failures.size==0
    failure_comparison[:combined_total_failures] = combined_total_failures unless combined_total_failures.size==0
    failure_comparison[:test_case_records_for_date_one] = test_case_records_with_errors_for_date_one unless test_case_records_with_errors_for_date_one.size==0
    failure_comparison[:test_case_records_for_date_two] = test_case_records_with_errors_for_date_two unless test_case_records_with_errors_for_date_two.size==0
    failure_comparison
  end

  def self.get_test_suite_records_with_errors_for(date, sub_project_id, test_category)
    test_metadata_for_date = TestMetadatum.get_record_for_specific_date(sub_project_id, test_category, date)
    test_suite_records_for_date = TestSuiteRecord.get_test_suite_records(test_metadata_for_date)
    test_case_records_for_date = []

    test_suite_records_for_date.each do |test_suite_record|
      test_case_records_for_date << TestCaseRecord.get_test_case_records_with_error(test_suite_record)
    end
    test_case_records_for_date.flatten
  end
end