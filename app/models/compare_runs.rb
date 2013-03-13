class CompareRuns

  def self.getCompareResult(form_data)
    sub_project_id=form_data["sub_projects"]
    test_category=form_data["test_types"]
    date_one = form_data["date_one"]["analysis"]
    date_two = form_data["date_two"]["analysis"]
    metadata = []
    metadata << TestMetadatum.get_latest_record_for_specific_date(sub_project_id, test_category, date_one)
    metadata << TestMetadatum.get_latest_record_for_specific_date(sub_project_id, test_category, date_two)

    result_hash=TestSuiteRecord.get_class_name_suite_id_hash(metadata[0].id, metadata[1].id)
    @test_case_id=[]
    result_hash.values.each do |suite_id_arrs|
      test_case_id1=[]
      test_case_id2=[]
      suite_id_arrs[0].zip(suite_id_arrs[1]).each do |id1, id2|
        test_case_id1<<TestCaseRecord.select("id").where("test_suite_record_id="+id1.to_s+" AND error_msg!='' ")
        test_case_id2<<TestCaseRecord.select("id").where("test_suite_record_id="+id2.to_s+" AND error_msg!='' ")
        @test_case_id << get_both_test_cases_failing(test_case_id1, test_case_id2)
      end
    end
    @test_case_id = @test_case_id.reject{|e| e.empty?}
    class_names_of_test_cases_failing=get_class_names(@test_case_id)
    class_name_hash = Hash.new()
    class_name_hash["both_failing"] = class_names_of_test_cases_failing
    class_name_hash
  end

  def self.get_both_test_cases_failing(test_case_id1, test_case_id2)
    test_case_id =[]
    if (!(test_case_id1[0].empty?)&&(!(test_case_id2[0].empty?)))
      if test_case_id1[0][0]["error_msg"]==test_case_id2[0][0]["error_msg"]
        test_case_id.push([test_case_id1[0][0]["id"], test_case_id2[0][0]["id"]])
      end
    end
    test_case_id
  end

  def self.get_class_names(test_case_id)
    class_name=[]
    test_case_id.each do |arr_test_case|
      class_name<<TestCaseRecord.find_by_id(arr_test_case[0]).class_name
    end
    class_name
  end
end