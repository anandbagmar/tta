class Parser
  def self.map_file_type_to_parser (input_file_path, output_file_path, meta_datum_id, params)
      file_hash =Unzip.unzip_files(input_file_path,output_file_path)
      file_hash.keys.each do |filename|
        contents = file_hash[filename]
        if filename =~ /\.xml$/ or filename =~ /\.html$/
          if contents.to_s.start_with? ("<?xml")
            parse_test_record(contents, meta_datum_id, params)
          elsif contents.to_s.start_with? ("<!DOCTYPE html")
            parse_test_record_html(contents, meta_datum_id, params)
          end
        elsif filename =~ /\.txt$/
          JasmineParser.new.parse(contents, meta_datum_id, params)
        end
      end
      end

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
      hash = {:time_taken => 0.0,:test_metadatum_id => meta_id,:class_name => test_suite.attr("name"),:number_of_tests=> test_suite.attr("tests"),
              :number_of_errors=> test_suite.attr("errors"),:number_of_failures=> test_suite.attr("failures")}
      @doc.xpath("//testsuite/testcase").each do |test_case|
        if test_report_type == "Rspec JUnit" || test_report_type == "Cucumber JUnit"
          time = XmlParser.new.get_time(test_case, test_suite, test_report_type)
        end
        hash[:time_taken] += time.to_f
        xml_data = TestSuiteRecord.create_and_save(hash)
        if test_report_type == "Rspec JUnit" || test_report_type == "Cucumber JUnit"
          XmlParser.new.saving_junit_test_cases(config_xml, test_case, xml_data, test_report_type, test_suite)
        elsif test_report_type == "Groovy NUnit"
          GroovyNunitParser.parse(config_xml, xml_data,test_case)
        end
      end
    end
  end
  def self.parse_test_record_html(config_html, meta_id, params)
    test_report_type = params[:test_report_type]
    if test_report_type == "Cucumber HTML"
      CucumberHtmlParser.parse(config_html,meta_id)
    end
  end
end

