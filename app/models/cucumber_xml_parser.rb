class CucumberXmlParser
  def self.parse(config_xml,test_suite,xml_data,test_case,test_report_type)
    if test_case.attr("classname") == test_suite.attr("name")
      XmlParser.parse_test_case(test_case,xml_data,config_xml,test_report_type)
    end
  end

  def self.get_error_message(config_xml,testcase_name)
    @error_msg=""
    node = Nokogiri::XML config_xml
    raw_string = node.search("//testsuite/testcase[@name='#{testcase_name}']/failure").children.text
    if !raw_string.empty?
      val = raw_string.index("Message:") + ("Message:").length
      @error_msg = raw_string[val+1..-1]
    end
    @error_msg
  end

  def self.get_time(test_case,test_suite)
    time=0.0
    if test_case.attr("classname").start_with?(test_suite.attr("name"))
      time+= test_case.attr("time").to_f
    end
    time
  end
end
