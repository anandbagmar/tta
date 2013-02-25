class NunitParser
  def self.get_test_suite_records(meta_data)
    test_suite_ids=[]
    meta_data.test_suite_records.each do |test_suite_record|
      test_suite_ids << test_suite_record.id unless test_suite_record.number_of_errors == 0
    end
    test_suite_ids
  end

  def self.get_total_test_n_total_failure(metadata_record)
    total_num_of_tests = 0
    number_of_failures = 0
    metadata_record.test_suite_records.each do |test_suite_record|
      total_num_of_tests += test_suite_record.number_of_tests.to_i
      number_of_failures += (test_suite_record.number_of_errors.to_i + test_suite_record.number_of_tests_not_run.to_i + test_suite_record.number_of_tests_ignored.to_i)
    end
    return number_of_failures, total_num_of_tests
  end

end
