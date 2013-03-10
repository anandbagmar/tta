class JasmineParser
  def parse(config_txt, meta_id, params)

    report_data = create_jasmine_data_array(config_txt)
    test_suite_summary =report_data.pop()
    # NEED TO CHECK LOGS ...
    save_jasmine_test_suite(meta_id, test_suite_summary)
    save_jasmine_test_cases(each_entry)
  end

  private

  def save_jasmine_test_suite(meta_id, test_suite_summary)
    hash={:test_metadatum_id=> meta_id,:class_name => "JasmineReports #{meta_id}",:number_of_tests=> test_suite_summary[1],
          :number_of_errors=> 0,:number_of_failures=> test_suite_summary[2],:time_taken =>test_suite_summary[3],:number_of_tests_ignored=> 0,
          :number_of_tests_not_run=> 0}
    TestSuiteRecord.create_and_save(hash)
  end

def save_jasmine_test_cases(each_entry)
  each_entry.each do |entry|
    @jasmine_test_case_data = TestCaseRecord.new()
    @jasmine_test_case_data.test_suite_record_id = @jasmine_test_suite_data.id
    @jasmine_test_case_data.class_name = entry[1]+entry[2]
    @jasmine_test_case_data.time_taken = 0.0
    if (entry[0]=="FAIL")
      @jasmine_test_case_data.error_msg = entry[3]
    end
    @jasmine_test_case_data.save
  end
end

def create_jasmine_data_array(config_txt)
  report = config_txt.split("\n");
  report_data=[]
  report.each do |data|
    report_data<< data.split("||");
  end
  report_data
end
end
