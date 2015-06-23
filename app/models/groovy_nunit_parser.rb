class GroovyNunitParser
  def self.parse(config_xml, xml_data, test_case)
    @doc = Nokogiri::XML config_xml

    xml_test_case = TestCaseRecord.new()
    xml_test_case.test_suite_record_id = xml_data.id
    xml_test_case.class_name = test_case.attr("name")
    xml_test_case.time_taken = test_case.attr("time")
    xml_test_case.error_msg = @doc.search("//system-err").children.text
    xml_test_case.save
  end

end