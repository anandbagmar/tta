class JasmineParser
  def self.parse(config_txt,meta_id,params)

    report = config_txt.split("\n");

    index=0
    report_data=[]
    report.each do|data|
      report_data[index]= data.split("||");
      index+=1
    end

    test_suite_partial_data =report_data.pop()

    @jasmine_test_suite_data = TestSuiteRecord.new()
    @jasmine_test_suite_data.test_metadatum_id=meta_id
    @jasmine_test_suite_data.class_name="JasmineReports #{meta_id}"
    @jasmine_test_suite_data.number_of_tests=test_suite_partial_data[1]
    @jasmine_test_suite_data.number_of_errors=0
    @jasmine_test_suite_data.number_of_failures=test_suite_partial_data[2]
    @jasmine_test_suite_data.time_taken=test_suite_partial_data[3]
    @jasmine_test_suite_data.number_of_tests_ignored=0
    @jasmine_test_suite_data.number_of_tests_not_run=0
    @jasmine_test_suite_data.save

    report_data.each do |each_entry|

      @jasmine_test_case_data = TestCaseRecord.new()
      @jasmine_test_case_data.test_suite_record_id = @jasmine_test_suite_data.id
      @jasmine_test_case_data.class_name = each_entry[1]+each_entry[2]
      @jasmine_test_case_data.time_taken = 0.0
        if(each_entry[0]=="FAIL")
          @jasmine_test_case_data.error_msg = each_entry[3]
        end
      @jasmine_test_case_data.save

    end
  end
end