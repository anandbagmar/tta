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
    binding.pry
    test_case_ids=[]
    binding.pry
    result_hash.values.each do |suite_id_arr|

        test_case_ids<<TestCaseRecord.select("id").where("test_suite_record_id IN "+case_id.to_s+" AND error_msg!='' ")
                                                                                                                              #NEEDS REFACTORING




        if test_case_ids.last.empty?
          test_case_ids.pop
        end
      end
    end




    # test_case_record_1=[]
    # test_case_record_2=[]


    #  class_names.each do |class_name|
    #   test_case_record_1,test_case_record_2=get_test_cases(metadata,class_name)

    #   compare_test_cases(test_case_record_1,test_case_record_2)


def self.compare_test_cases(case_record_1, case_record_2)
  test_case_record1=TestCaseRecord.find_all_by_test_suite_record_id(result_hash["Project"][0])
  test_case_record2= TestCaseRecord.find_all_by_test_suite_record_id(result_hash["Project"][1])

  TestCaseRecord.select("id").where("test_suite_record_id = 51 AND error_msg!='' ")
end


def self.get_test_cases(metadata_record, class_name)
  test_case_records_1 = []
  test_case_records_2 = []

  metadata_record[0].test_suite_records.each do |suite_record|
    suite_record.test_case_records.each do |case_records|

      test_case_records_1 << case_records
    end
  end
  metadata_record[1].test_suite_records.each do |suite_record|
    suite_record.test_case_records.each do |case_records|
      test_case_records_2 << case_records
    end
  end
  return test_case_records_1, test_case_records_2
end


#class_names.each do |class_name|
#  test_suite_records=extract_test_suite_records(test_metadata_ids,class_names[0])
#binding.pry
#test_case_records=extract_test_case_records(test_suite_records)
#binding.pry
#compare_test_case_records(test_case_records)
#end


#def self.compare_test_case_records(test_case_records)
#end
#def self.extract_test_case_records(test_suite_records)
#  test_case_records=[]
#  #index=1;
#  #key=""
#  test_suite_records.each do|suite_record|
#   #key="date_"+index.to_s
#    suite_record.test_case_records.each do |case_record|
#       test_case_records << case_record
#    end
#    #index+=1
#  end
#  binding.pry
#  test_case_records
#end


#def self.extract_test_suite_records(test_metadata_ids,class_name)
#   test_case=[]
#   test_metadata_ids.each do |metadata_id|
#     test_suites = TestSuiteRecord.where(:class_name => class_name,:test_metadatum_id => metadata_id)
#     test_cases  =test_suites.test_case_records
#     binding.pry
#  end
#
#end
end