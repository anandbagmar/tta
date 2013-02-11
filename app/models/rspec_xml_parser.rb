class RspecXmlParser
 def self.parse(config_xml, test_suite,xml_data,test_case,test_report_type)
   @doc = Nokogiri::XML config_xml
   if test_case.attr("name").start_with?(test_suite.attr("name")+" ")
     #parse_test_case(config_xml,test_suite,xml_data,test_case)
     XmlParser.parse_test_case(test_case, xml_data, config_xml,test_report_type)
   end
 end
  def self.get_error_message(config_xml,xml_test_case,testcase_name)
    node = Nokogiri::XML config_xml
    cdata = node.search("//testsuite/testcase[@name='#{testcase_name}']/failure").children.find { |e| e.cdata? }
    cdata_msg = cdata.to_s
    @error_msg=cdata_msg.scan(/\[CDATA\[((.|\s)*)\]\]/m).first
  end
end

