class ExecutionTrends
  def get_result_set(class_name, start_date, end_date)
    result_set = {}
    result_set[class_name], max_val = get_time_taken(class_name, start_date, end_date) if class_name && class_name.length > 0
    return result_set, max_val
  end

  def get_class_names(sub_project_id, test_category, start_date, end_date)
    metadataRecords = TestMetadatum.where("sub_project_id = ? AND test_category =? AND date_of_execution BETWEEN ? AND ?", "#{sub_project_id}", "#{test_category}", "#{start_date}", "#{end_date}").select("id").uniq
    testSuiteRecords = TestSuiteRecord.where("test_metadatum_id IN (?)", metadataRecords.map { |r| r.id }).select("id").uniq
    class_names = TestCaseRecord.where("test_suite_record_id IN (?)", testSuiteRecords.map { |r| r.id }).select("class_name").uniq
    class_names
  end

  def get_time_taken(class_name, start_date, end_date)
    test_case_records_by_class_name = TestCaseRecord.where(:class_name => class_name).select("test_suite_record_id,time_taken")
    test_case_execution_date_time = []
    test_case_records_by_class_name.each do |test_case_record|
      metadata_id = TestSuiteRecord.where(:id => test_case_record.test_suite_record_id).select("test_metadatum_id")
      execution_date =TestMetadatum.where("id = ? AND date_of_execution BETWEEN ? AND ?", metadata_id[0].test_metadatum_id, "#{start_date}", "#{end_date}").select("date_of_execution")
      test_case_execution_date_time << [execution_date[0].date_of_execution.to_time.to_f * 1000, test_case_record.time_taken.to_f] unless execution_date==[]
    end
    return test_case_execution_date_time.sort, ((test_case_execution_date_time.map { |value| value[1] }.max || 0) + 1)
  end

end