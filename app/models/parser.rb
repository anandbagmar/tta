class Parser
  #job  - unzipping
  def self.unzip_files (input_file_path, output_file_path, meta_datum_id, params)
    FileUtils.cp input_file_path, output_file_path
    Zip::ZipFile.open(output_file_path) do |zipFile|
      zipFile.each do |entry|
        filename=entry.to_s
        contents = zipFile.read(entry)
        contents_string= contents.to_s
        if filename =~ /\.xml$/
          if contents_string.start_with? ("<?xml")
            parse_test_record(contents, meta_datum_id, params)
          end
        end
        if filename =~ /\.xml$/ or filename =~ /\.html$/
          if contents_string.start_with? ("<?xml")
            parse_test_record(contents, meta_datum_id, params)
          end
          if contents_string.start_with? ("<!DOCTYPE html")
            parse_test_record_html(contents, meta_datum_id, params)
          end
        end
      end
    end
  end

  #job: parsing
  def self.parse_test_record(config_xml, meta_id, params)
    @doc = Nokogiri::XML config_xml
    test_report_type = params[:test_report_type]

    if test_report_type == "Unit NUnit"
      return UnitNunitParser.parse(config_xml, meta_id)
    else
      test_suites = @doc.xpath("//testsuite")
    end

    test_suites.each do |test_suite|
      time = test_suite.attr("time").to_f
      @xml_data = TestSuiteRecord.new()
      @xml_data.time_taken = 0.0
      @xml_data.test_metadatum_id = meta_id
      @xml_data.class_name= test_suite.attr("name")
      @xml_data.number_of_tests= test_suite.attr("tests")
      @xml_data.number_of_errors= test_suite.attr("errors")
      @xml_data.number_of_failures= test_suite.attr("failures")
      @doc.xpath("//testsuite/testcase").each do |test_case|
        if test_report_type == "Rspec JUnit" || test_report_type == "Cucumber JUnit"
          time = XmlParser.get_time(test_case, test_suite, test_report_type)
        end
        @xml_data.time_taken += time.to_f
        @xml_data.save
        if test_report_type == "Rspec JUnit" || test_report_type == "Cucumber JUnit"
          XmlParser.saving_junit_test_cases(config_xml, test_case, @xml_data, test_report_type, test_suite)
        elsif test_report_type == "Groovy NUnit"
          GroovyNunitParser.parse(config_xml, @xml_data,test_case)
        end
      end
    end
  end
end

