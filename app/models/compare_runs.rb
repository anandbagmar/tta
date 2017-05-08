class CompareRuns

  def self.getCompareResult(form_data)
    platform_id                                         =form_data['platforms']
    test_category                                       =form_data['test_category']
    date_one                                            = form_data['date_one']
    date_two                                            = form_data['date_two']
    failure_comparison                                  = {}
    failure_comparison[:test_case_records_for_date_one] = get_test_case_records_with_errors_for(date_one, platform_id, test_category) || []
    failure_comparison[:test_case_records_for_date_two] = get_test_case_records_with_errors_for(date_two, platform_id, test_category) || []
    failure_comparison[:common_failures]                = get_common_test_case_records_with_errors_in_two_dates(platform_id, test_category, date_one, date_two)
    failure_comparison[:combined_total_failures]        = get_combined_test_case_records_with_errors_in_two_dates(platform_id, test_category, date_one, date_two)
    failure_comparison
  end

  def self.get_combined_test_case_records_with_errors_in_two_dates(platform_id, test_category, date_one, date_two)
    test_suite_records_for_date_one = get_test_suite_records(platform_id, test_category, date_one)
    test_suite_records_for_date_two = get_test_suite_records(platform_id, test_category, date_two)

    TestCaseRecord.get_combined_test_case_records_with_errors_in_two_dates(test_suite_records_for_date_one, test_suite_records_for_date_two) || []
  end

  def self.get_test_case_records_with_errors_for(date, platform_id, test_category)
    test_suite_records_for_date = get_test_suite_records(platform_id, test_category, date)

    TestCaseRecord.get_test_case_records_with_error(test_suite_records_for_date)
  end

  def self.get_test_suite_records(platform_id, test_category, date)
    test_metadata_for_date = TestMetadatum.get_record_for_specific_date(platform_id, test_category, date)

    TestSuiteRecord.get_test_suite_records(test_metadata_for_date)
  end

  def self.get_common_test_case_records_with_errors_in_two_dates(platform_id, test_category, date_one, date_two)
    test_suite_records_for_date_one = get_test_suite_records(platform_id, test_category, date_one)
    test_suite_records_for_date_two = get_test_suite_records(platform_id, test_category, date_two)

    TestCaseRecord.get_common_test_case_records_with_errors_in_two_dates(test_suite_records_for_date_one, test_suite_records_for_date_two) || []
  end
end