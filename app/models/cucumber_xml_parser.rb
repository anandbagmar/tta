class CucumberXmlParser
  #def self.parse(config_xml, test_suite, xml_data, test_report_type)
  #  @doc = Nokogiri::XML config_xml
  #  name= test_suite.attr('name')
  #  test_cases = @doc.xpath("//testsuite[@name='#{name}']/testcase")
  #  test_cases.each do |test_case|
  #    if test_case.attr("classname") == test_suite.attr("name")
  #      JunitXmlParser.new.parse_test_case(test_case, xml_data, config_xml, test_report_type)
  #    end
  #  end
  #end

  def self.get_error_message(config_xml, testcase_name)
    @error_msg =""
    node       = Nokogiri::XML config_xml
    raw_string = node.search("//testsuite/testcase[@name='#{testcase_name}']/failure").children.text
    if !raw_string.empty?
      val        = raw_string.index("Message:") + ("Message:").length
      @error_msg = raw_string[val+1..-1]
    end
    @error_msg
  end
end

