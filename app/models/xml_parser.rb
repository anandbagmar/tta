class XmlParser

  #job  - zipping, parse, saving
  def self.parse (input_file_path, output_file_path, meta_datum_id)
  FileUtils.cp input_file_path , output_file_path
  Zip::ZipFile.open(output_file_path) do |zipFile|
    zipFile.each do |entry|
      filename=entry.to_s
      contents = zipFile.read(entry)
      contents_string= contents.to_s
      if filename =~ /\.xml$/
        if contents_string.start_with? ("<?xml")
          parse_xml(contents, meta_datum_id)
        end
      end
    end
  end
  end

  private
  def self.parse_xml(config_xml, meta_id)
    @doc = Nokogiri::XML config_xml
    @doc.xpath("//testsuite").each do |p|
      time = 0
      @xml_data = TestSuiteRecord.new()
      @xml_data.test_metadatum_id = meta_id
      @xml_data.class_name= p.attr("name")
      @xml_data.number_of_tests= p.attr("tests")
      @xml_data.number_of_errors= p.attr("errors")
      @xml_data.number_of_failures= p.attr("failures")
      @doc.xpath("//testsuite/testcase").each do |q|
        if q.attr("name").start_with? (p.attr("name")+" ")
          time += q.attr("time").to_f
        end
      end
      @xml_data.time_taken = time.to_s
      @xml_data.save
      @doc.xpath("//testsuite/testcase").each do |q|
        if q.attr("name").start_with? (p.attr("name")+" ")
          @xml_test_case = TestCaseRecord.new()
          @xml_test_case.test_suite_record_id= @xml_data.id
          @xml_test_case.class_name = q.attr("name")
          testcase_name=q.attr("name")
          @xml_test_case.time_taken = q.attr("time")
          if @xml_data.number_of_failures.to_i > 0
            @doc.xpath("//testsuite/testcase/failure").each do |w|
              node = Nokogiri::XML config_xml
              cdata = node.search("//testsuite/testcase[@name='#{testcase_name}']/failure").children.find{|e| e.cdata?}
              str = cdata.to_s
              str1=str.scan(/\[CDATA\[((.|\s)*)\]\]/m).first
              @xml_test_case.error_msg = str1
            end
          end
          @xml_test_case.save
        end
      end
    end
  end
end