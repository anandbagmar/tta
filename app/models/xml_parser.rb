class XmlParser

  def parse_xml_testsuite(config_xml, meta_id, params)
    parse_test_run_record_xml(config_xml, meta_id, params)
  end

  def create_test_case(test_case_xml, test_report_type)
    xml_test_case = TestCaseRecord.new()
    xml_test_case.class_name = test_case_xml.attr("name")
    xml_test_case.time_taken = test_case_xml.attr("time")
    if test_report_type.eql?("junit")
      @error_msg = test_case_xml.search(".//failure").text
    elsif test_report_type.eql?("Cucumber junit")
      @error_msg = CucumberXmlParser.get_error_message(test_case_xml, xml_test_case.class_name)
    end
    xml_test_case.error_msg = @error_msg.gsub("\"","'")
    xml_test_case
  end

  def get_time(test_case,test_suite,test_report_type)
    if test_report_type == "junit" || test_report_type == "Cucumber junit"
      time = test_case.attr("time").to_f
    else
      time = test_suite.attr("time").to_f
    end
    time
  end

  def get_test_suite_records(meta_data)
    test_suite_ids=[]
    meta_data.test_suite_records.each do |test_suite_record|
      test_suite_ids << test_suite_record.id unless (test_suite_record.number_of_failures == 0 and test_suite_record.number_of_errors == 0)
    end
    test_suite_ids
  end

  def get_total_test_n_total_failure(metadata_record)
    total_num_of_tests = 0
    number_of_failures = 0
    metadata_record.test_suite_records.each do |test_suite_record|
      total_num_of_tests += test_suite_record.number_of_tests.to_i
      number_of_failures += test_suite_record.number_of_failures.to_i
    end
    return number_of_failures, total_num_of_tests
  end
end




