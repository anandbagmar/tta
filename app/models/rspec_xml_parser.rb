class RspecXmlParser
  def self.parse(config_xml, test_suite, xml_data, test_case, test_report_type)
    if test_case.attr("name").start_with?(test_suite.attr("name")+" ")
      XmlParser.parse_test_case(test_case, xml_data, config_xml, test_report_type)
    end
  end

  def self.get_error_message(config_xml, testcase_name)
    node = Nokogiri::XML config_xml
    cdata = node.search("//testsuite/testcase[@name='#{testcase_name}']/failure").children.find { |e| e.cdata? }
    cdata_msg = cdata.to_s
    @error_msg=cdata_msg.scan(/\[CDATA\[((.|\s)*)\]\]/m).first
    if !(@error_msg.nil?)
      return @error_msg[0]
    end
    @error_msg
  end

  def self.get_time(test_case, test_suite)
    time=0.0
    if test_case.attr("name").start_with?(test_suite.attr("name")+" ")
      time+= test_case.attr("time").to_f
    end
    time
  end
end

