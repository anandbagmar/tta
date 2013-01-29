class XmlParser

  #job  - zipping, parse, saving
  def self.parse (input_file_path, output_file_path, meta_datum_id, params)
    FileUtils.cp input_file_path, output_file_path
    Zip::ZipFile.open(output_file_path) do |zipFile|
      zipFile.each do |entry|
        filename=entry.to_s
        contents = zipFile.read(entry)
        contents_string= contents.to_s
        if filename =~ /\.xml$/
          if contents_string.start_with? ("<?xml")
            parse_xml_testsuite(contents, meta_datum_id, params)
          end
        end
      end
    end
  end

  private
  def self.parse_xml_testsuite(config_xml, meta_id, params)
    @doc = Nokogiri::XML config_xml
    @doc.xpath("//testsuite").each do |test_suite|
      time = test_suite.attr("time").to_f
      @xml_data = TestSuiteRecord.new()
      @xml_data.test_metadatum_id = meta_id
      @xml_data.class_name= test_suite.attr("name")
      @xml_data.number_of_tests= test_suite.attr("tests")
      @xml_data.number_of_errors= test_suite.attr("errors")
      @xml_data.number_of_failures= test_suite.attr("failures")
      @doc.xpath("//testsuite/testcase").each do |test_case|
        if test_case.attr("name").start_with? (test_suite.attr("name")+" ")
          time += test_case.attr("time").to_f
        end
      end
      @xml_data.time_taken = time.to_s
      @xml_data.save
      test_report_type= params[:test_report_type]
      if test_report_type == "Rspec JUnit"
        saving_rspec_test_cases(config_xml, test_suite)
      elsif test_report_type == "Cucumber JUnit"
        saving_cucumber_test_cases(config_xml, test_suite)
      end
    end
  end

  def self.saving_rspec_test_cases(config_xml, test_suite)
    @doc = Nokogiri::XML config_xml
    @doc.xpath("//testsuite/testcase").each do |test_case|
      if test_case.attr("name").start_with?(test_suite.attr("name")+" ")
        @xml_test_case = TestCaseRecord.new()
        @xml_test_case.test_suite_record_id= @xml_data.id
        @xml_test_case.class_name = test_case.attr("name")
        testcase_name=test_case.attr("name")
        @xml_test_case.time_taken = test_case.attr("time")
        if @xml_data.number_of_failures.to_i > 0
          @doc.xpath("//testsuite/testcase/failure").each do |failure|
            node = Nokogiri::XML config_xml
            cdata = node.search("//testsuite/testcase[@name='#{testcase_name}']/failure").children.find { |e| e.cdata? }
            cdata_msg = cdata.to_s
            error_msg=cdata_msg.scan(/\[CDATA\[((.|\s)*)\]\]/m).first
            @xml_test_case.error_msg = error_msg
          end
        end
        @xml_test_case.save
      end
    end
  end

  def self.saving_cucumber_test_cases(config_xml, test_suite)
    @doc = Nokogiri::XML config_xml
    @doc.xpath("//testsuite/testcase").each do |test_case|
      if test_case.attr("classname") == test_suite.attr("name")
        @xml_test_case = TestCaseRecord.new()
        @xml_test_case.test_suite_record_id= @xml_data.id
        @xml_test_case.class_name = test_case.attr("name")
        testcase_name=test_case.attr("name")
        @xml_test_case.time_taken = test_case.attr("time")
        if @xml_data.number_of_failures.to_i > 0
          @doc.xpath("//testsuite/testcase/failure").each do |w|
            node = Nokogiri::XML config_xml
            raw_string = node.search("//testsuite/testcase[@name='#{testcase_name}']/failure").children.text
            val = raw_string.index("Message:")+("Message:").length
            @xml_test_case.error_msg = raw_string[val+1..-1]
          end
        end
        @xml_test_case.save
      end
    end
  end

end




