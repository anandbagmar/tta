class RspecXmlParser
  def parse(config_xml, test_suite, xml_data, test_report_type)
    @doc = Nokogiri::XML config_xml
    name=test_suite.attr("name")
    test_cases = @doc.xpath("//testsuite[@name='#{name}']/testcase")
    test_cases.each do |test_case|
    if test_case.attr("name").start_with?(test_suite.attr("name")+" ")
      XmlParser.new.parse_test_case(test_case, xml_data, config_xml, test_report_type)
    end
      end
  end

  def get_error_message(config_xml, testcase_name)
    node = Nokogiri::XML config_xml
    cdata = node.search("//testsuite/testcase[@name='#{testcase_name}']/failure").children.find { |e| e.cdata? }
    cdata_msg = cdata.to_s
    @error_msg=cdata_msg.scan(/\[CDATA\[((.|\s)*)\]\]/m).first
    if !(@error_msg.nil?)
      return @error_msg[0]
    end
    @error_msg
  end

  def get_time(test_case, test_suite)
    time=0.0
    if test_case.attr("name").start_with?(test_suite.attr("name")+" ")
      time+= test_case.attr("time").to_f
    end
    time
  end
end

