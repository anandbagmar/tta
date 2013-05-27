class RspecXmlParser
  #def parse(extracted_xml, test_suite_xml,test_report_type,saved_test_suite_data)
  #  @doc = Nokogiri::XML extracted_xml
  #  name=test_suite_xml.attr("name")
  #  test_cases_xml = @doc.xpath("//testsuite[@name='#{name}']/testcase")
  #  test_cases_xml.each do |test_case_xml|
  #    if test_case_xml.attr("name").start_with?(test_suite_xml.attr("name")+" ")
  #      XmlParser.new.parse_test_case(test_case_xml, saved_test_suite_data, extracted_xml, test_report_type)
  #    end
  #  end
  #end

  #def get_error_message(failure_xml)
  #  @error_msg=failure_xml.to_s.scan(/\[CDATA\[((.|\s)*)\]\]/m).first
  #  if !(@error_msg.nil?)
  #    return @error_msg[0]
  #  end
  #  @error_msg
  #end
end

