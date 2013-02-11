class CucumberXmlParser
  def self.parse(config_xml,test_suite,xml_data,test_case,test_report_type)
    @doc = Nokogiri::XML config_xml
      if test_case.attr("classname") == test_suite.attr("name")
        XmlParser.parse_test_case(test_case,xml_data,config_xml,test_report_type)
      end
  end

  def self.get_error_message(config_xml,xml_test_case,testcase_name,test_report_type)
    node = Nokogiri::XML config_xml
    raw_string = node.search("//testsuite/testcase[@name='#{testcase_name}']/failure").children.text
    val = raw_string.index("Message:") + ("Message:").length
    @error_msg = raw_string[val+1..-1]
  end
end
