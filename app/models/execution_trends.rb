class ExecutionTrends
  def get_result_set(class_name)
    result_set = {}
    result_set[class_name],max_val = get_time_taken(class_name) if class_name && class_name.length > 0
    return result_set,max_val
  end

  def get_time_taken(class_name)
    case_record = TestCaseRecord.where(:class_name => class_name).select("test_suite_record_id,time_taken")
    final_result=case_record.inject([]) { |result, test_case_record|
      suite_record = TestSuiteRecord.where(:id => test_case_record.test_suite_record_id).select("test_metadatum_id")
      metadataDateEntry = TestMetadatum.where(:id => suite_record).select("date_of_execution")
      result << [metadataDateEntry[0].date_of_execution.to_time.to_f * 1000, test_case_record.time_taken.to_f]
    }
    return final_result, final_result.map {|value| value[1]}.max + 1
  end

  def get_class_names(sub_project_id, test_category, start_date, end_date)
    metadataRecords = TestMetadatum.where("sub_project_id = ? AND test_category =? AND date_of_execution BETWEEN ? AND ?", "#{sub_project_id}", "#{test_category}", "#{start_date}", "#{end_date}").select("id").uniq
    testSuiteRecords = TestSuiteRecord.where("test_metadatum_id IN (?)", metadataRecords.map { |r| r.id }).select("id").uniq
    class_names = TestCaseRecord.where("test_suite_record_id IN (?)", testSuiteRecords.map { |r| r.id }).select("class_name").uniq
    class_names
  end
end