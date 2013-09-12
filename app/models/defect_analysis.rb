class DefectAnalysis
  def get_result_json(sub_project_id, analysis_date, test_category)
    test_case_hash, no_of_test = getMetadataIds(sub_project_id, analysis_date, test_category)
    if !(no_of_test.nil?)
      percentage = get_defect_percentage(no_of_test.flatten)
      defect_analysis_json = {
          :sub_project_name => SubProject.find(sub_project_id, :select => "name").name,
          :errors => test_case_hash,
          :percentage => percentage
      }.to_json
    else
      defect_analysis_json ={
          :errors => test_case_hash
      }
    end
    return defect_analysis_json
  end

  def get_defect_percentage(no_of_test)
    sum=no_of_test.inject { |sum, x| sum + x }
    percentage=[]
    no_of_test.each do |test|
      percentage<< "%0.2f" %(test.to_f / sum.to_f * 100)
    end
    percentage
  end

  def getMetadataIds(sub_project_id, analysis_date, test_category)
    @final_result_hash = {}
    @final_test_for_particular_error=[]
    @index=0
    if (test_category=="ALL")
      analysis_date=analysis_date.to_date
      test_category = get_record_with_distinct_test_category(sub_project_id)
      test_category.each do |test_type|
        meta_data = SubProject.find(sub_project_id).test_metadatum.find_all_by_date_of_execution(analysis_date.beginning_of_day..analysis_date.end_of_day, :conditions => ["test_category = ?", test_type])
        getResultHash(test_type, meta_data)
      end
    else
      meta_data= SubProject.find(sub_project_id).test_metadatum.find_all_by_date_of_execution(analysis_date, :conditions => ["test_category = ?", test_category])
      getResultHash(test_category, meta_data)
    end
    return @final_result_hash, @final_test_for_particular_error
  end

  def getResultHash(test_type, meta_data)
    no_of_test_for_particular_error=[]
    result_hash = {}
    meta_data.sort_by &:date_of_execution
    meta_data = meta_data.last
    if !(meta_data.nil?)
      test_report_type = meta_data.test_report_type
      nunit_flag = (test_report_type=="Unit NUnit"||test_report_type =="Groovy NUnit") ? 1 : 0
      test_suite_ids=(nunit_flag == 1 ? NunitParser.get_test_suite_records(meta_data) : XmlParser.new.get_test_suite_records(meta_data))
    end
    if !(test_suite_ids.nil?)
      result_hash, no_of_test_for_particular_error = get_test_cases(test_suite_ids)
      @final_result_hash[test_type] = [] unless result_hash.keys.include?(test_type)
      @final_result_hash[test_type] << result_hash unless result_hash.nil?
      @final_test_for_particular_error[@index]=no_of_test_for_particular_error
      @index+=1
    end
  end

  def get_test_cases(result)
    test_cases=[]
    no_of_test_for_particular_error=[]
    result.each do |test_suite_id|
      test_cases << TestCaseRecord.find_all_by_test_suite_record_id(test_suite_id, :select => "class_name , error_msg")
    end
    error_hash = {}
    test_cases.each do |test_case|
      test_case.each do |test|
        if !(test.error_msg.blank?||test.error_msg.nil?)
          error_message = test.error_msg
          error_hash[error_message] = [] unless error_hash.keys.include?(error_message)
          error_hash[error_message] << test.class_name unless test.nil?
        end
      end
    end
    error_hash.each_key do |key|
      no_of_test_for_particular_error << error_hash[key].count
    end
    return error_hash, no_of_test_for_particular_error
  end

  def get_record_with_distinct_test_category(sub_project_id)
    metadata_with_distinct_test_category = TestMetadatum.new.get_distinct_test_category(sub_project_id)
    @test_category=[]
    metadata_with_distinct_test_category.each do |test_type|
      @test_category << test_type.test_category
    end
    return @test_category
  end

end


