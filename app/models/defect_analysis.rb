class DefectAnalysis
  def self.getResultJson(sub_project_id, analysis_date)
    test_case_hash = getMetadataIds(sub_project_id, analysis_date)
    defect_analysis_json = {
        :sub_project_name => SubProject.find(sub_project_id, :select => "name").name,
        :errors => test_case_hash
    }.to_json
    return defect_analysis_json
  end

  def self.getMetadataIds(sub_project_id, analysis_date)
    analysis_date_morning =analysis_date + " 00:00:00"
    analysis_date_night = analysis_date + " 23:59:59"
    meta_data = SubProject.find(sub_project_id).test_metadatum.find_all_by_date_of_execution(analysis_date_morning..analysis_date_night)
    meta_data.sort_by &:date_of_execution
    meta_data1 = meta_data.last
    if meta_data1.nil?
      return
    end
    test_suite_ids=[]
    meta_data1.test_suite_records.each do |test_suite_record|
     test_suite_ids << test_suite_record.id
    end

    return get_test_cases(test_suite_ids)
  end

  def self.get_test_cases(result)
    test_cases=[]
    result.each do |test_suite_id|
      test_cases << TestCaseRecord.find_by_test_suite_record_id(test_suite_id, :select => "class_name , error_msg", :conditions => "error_msg IS NOT NULL")
    end
    result_hash = {}
    test_cases.each do |test_case|
      if !(test_case.nil?)
        error_message = test_case.error_msg
        result_hash[error_message] = [] unless result_hash.keys.include?(error_message)
        result_hash[error_message] << test_case.class_name unless test_case.nil?
      end
    end
    return result_hash
  end
end








