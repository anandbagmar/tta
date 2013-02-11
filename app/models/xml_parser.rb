class XmlParser

  private
  def self.parse_xml_testsuite(config_xml, meta_id, params)
    parse_test_record(config_xml, meta_id, params)
  end

  def self.saving_junit_test_cases(config_xml, test_suite,xml_data,test_report_type)
    @doc = Nokogiri::XML config_xml
    @doc.xpath("//testsuite/testcase").each do |test_case|
      if test_report_type.eql?("Rspec JUnit")
        RspecXmlParser.parse(config_xml, test_suite,xml_data,test_case,test_report_type)
      elsif test_report_type.eql?("Cucumber JUnit")
        CucumberXmlParser.parse(config_xml, test_suite,xml_data,test_case,test_report_type)
      end
    end
  end

  def self.parse_test_case(test_case, xml_data, config_xml,test_report_type)
    @xml_test_case = TestCaseRecord.new()
    @xml_test_case.test_suite_record_id= xml_data.id
    @xml_test_case.class_name = test_case.attr("name")
    testcase_name=test_case.attr("name")
    @xml_test_case.time_taken = test_case.attr("time")
    if xml_data.number_of_failures.to_i > 0
      @doc.xpath("//testsuite/testcase/failure").each do |failure|
        if test_report_type.eql?("Rspec JUnit")
          @error_msg = RspecXmlParser.get_error_message(config_xml,@xml_test_case,testcase_name)
        elsif test_report_type.eql?("Cucumber JUnit")
          @error_msg = CucumberXmlParser.get_error_message(config_xml,@xml_test_case,testcase_name,test_report_type)
        end
        @xml_test_case.error_msg = @error_msg
      end
    end
    @xml_test_case.save
  end
end




