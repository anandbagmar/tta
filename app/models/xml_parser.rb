class XmlParser

  def parse_xml_testsuite(config_xml, meta_id, params)
    parse_test_run_record_xml(config_xml, meta_id, params)
  end

  def saving_junit_test_cases(config_xml, xml_data, test_report_type, test_suite)
    if test_report_type.eql?("Rspec JUnit")
      RspecXmlParser.new.parse(config_xml, test_suite, xml_data, test_report_type)
    elsif test_report_type.eql?("Cucumber JUnit")
      CucumberXmlParser.parse(config_xml, test_suite, xml_data, test_report_type)
    end
  end

  def parse_test_case(test_case, xml_data, config_xml, test_report_type)
    @doc = Nokogiri::XML config_xml
    @xml_test_case = TestCaseRecord.new()
    @xml_test_case.test_suite_record_id= xml_data.id
    @xml_test_case.class_name = test_case.attr("name")
    testcase_name=test_case.attr("name")
    @xml_test_case.time_taken = test_case.attr("time")
    if xml_data.number_of_failures.to_i > 0
      @doc.xpath("//testsuite/testcase/failure").each do |failure|
        if test_report_type.eql?("Rspec JUnit")
          @error_msg = RspecXmlParser.new.get_error_message(config_xml, testcase_name)
        elsif test_report_type.eql?("Cucumber JUnit")
          @error_msg = CucumberXmlParser.get_error_message(config_xml, testcase_name)
        end
        @xml_test_case.error_msg = @error_msg
      end
    end
    @xml_test_case.save
  end

  def get_time(test_case, test_suite, test_report_type)
    if test_report_type == "Rspec JUnit"
      time = RspecXmlParser.new.get_time(test_case, test_suite)
    elsif test_report_type == "Cucumber JUnit"
      time = CucumberXmlParser.get_time(test_case, test_suite)
    else
      time = test_suite.attr("time").to_f
    end
    time
  end

  def get_test_suite_records(meta_data)
    test_suite_ids=[]
    meta_data.test_suite_records.each do |test_suite_record|
      test_suite_ids << test_suite_record.id unless test_suite_record.number_of_failures == 0
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




