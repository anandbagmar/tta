class JunitXmlParser

  def self.parse(extracted_xml, meta_id, test_report_type)
    @doc            = Nokogiri::XML extracted_xml
    test_suites_xml = @doc.xpath("//testsuite")
    test_suites_xml.each do |test_suite_xml|
      save_test_suite(meta_id, test_report_type, test_suite_xml)
    end
  end

  def self.save_test_suite(meta_id, test_report_type, test_suite_xml)
    test_suite_record_to_be_created = { :time_taken         => 0.0,
                                        :test_metadatum_id  => meta_id,
                                        :class_name         => test_suite_xml.attr("name"),
                                        :number_of_tests    => test_suite_xml.attr("tests"),
                                        :number_of_errors   => test_suite_xml.attr("errors"),
                                        :number_of_failures => test_suite_xml.attr("failures")
    }
    test_cases_to_be_created        = []
    test_suite_xml.search(".//testcase").each do |test_case_xml|
      test_suite_record_to_be_created[:time_taken] += JunitXmlParser.new.get_time(test_case_xml, test_suite_xml, test_report_type)
      test_cases_to_be_created << JunitXmlParser.new.create_test_case(test_case_xml, test_report_type)
    end
    saved_test_suite_data = TestSuiteRecord.create_and_save(test_suite_record_to_be_created)
    test_cases_to_be_created.each do |each_test_case|
      each_test_case.test_suite_record_id= saved_test_suite_data.id
      each_test_case.save
    end
  end

  def create_test_case(test_case_xml, test_report_type)
    xml_test_case            = TestCaseRecord.new()
    xml_test_case.class_name = test_case_xml.attr("name")
    xml_test_case.time_taken = test_case_xml.attr("time")
    if test_report_type.eql?("junit")
      @error_msg = test_case_xml.search(".//failure").text
    elsif test_report_type.eql?("Cucumber junit")
      @error_msg = CucumberXmlParser.get_error_message(test_case_xml, xml_test_case.class_name)
    end
    xml_test_case.error_msg = @error_msg.gsub("\"", "'")
    xml_test_case
  end

  def get_time(test_case, test_suite, test_report_type)
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




