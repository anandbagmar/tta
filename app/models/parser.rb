class Parser
  REPORTTYPE = YAML.load(File.open("#{Rails.root}/config/parser_defs.yml", "r"))

  def parse_test_log_files (input_file_path, output_file_path, meta_datum_id, test_report_type)
    extracted_files =Unzip.copy_and_extract_files(input_file_path, output_file_path)
    test_report_file_type = REPORTTYPE["test_report_type_mapping"][test_report_type.downcase]
    extracted_files.keys.each do |extracted_filename|
      extracted_file_content = extracted_files[extracted_filename]
      parse_file(meta_datum_id, test_report_file_type, test_report_type, extracted_file_content)
    end
  end

  def parse_file(meta_datum_id, test_report_file_type, test_report_type, extracted_file_content)
    parse_test_run_record_xml(meta_datum_id, test_report_type, extracted_file_content)
    parse_test_run_record_html(meta_datum_id, test_report_type, extracted_file_content)
    parse_test_run_record_jasmine(meta_datum_id, test_report_type, extracted_file_content)

    #if extracted_filename =~ /\.xml$/ or extracted_filename =~ /\.html$/
    #  if extracted_file_content.to_s.start_with? ("<?xml")
    #    parse_test_record_xml(extracted_file_content, meta_datum_id, test_report_type)
    #  elsif extracted_file_content.to_s.start_with? ("<!DOCTYPE html")
    #    parse_test_record_html(extracted_file_content, meta_datum_id, test_report_type)
    #  end
    #elsif extracted_filename =~ /\.txt$/
    #  parse_test_record_jasmine(extracted_file_content, meta_datum_id, test_report_type)
    #end
  end

  def parse_test_run_record_jasmine(meta_datum_id, test_report_type, extracted_file_content)
    return if (REPORTTYPE["test_report_type_mapping"][test_report_type.downcase] != "xml")
    #JasmineParser.new.parse(extracted_file_content, meta_datum_id, test_report_type)
  end

  def parse_test_run_record_nunit_xml(meta_id, test_report_type, extracted_xml)
    return if (REPORTTYPE["test_report_type_mapping"][test_report_type.downcase] != "xml")
    UnitNunitParser.parse(extracted_xml, meta_id)
  end

  def parse_test_run_record_html(meta_id, test_report_type, extracted_html)
    return if (REPORTTYPE["test_report_type_mapping"][test_report_type.downcase] != "html")
    if test_report_type == "Cucumber HTML"
      CucumberHtmlParser.parse(extracted_html, meta_id)
    end
  end

  def parse_test_run_record_xml(meta_id, test_report_type, extracted_xml)
    return if (REPORTTYPE["test_report_type_mapping"][test_report_type.downcase] != "xml")

    @doc = Nokogiri::XML extracted_xml

    test_suites = @doc.xpath("//testsuite")
    test_suites.each do |test_suite|
      save_test_suite(meta_id, test_report_type, extracted_xml, test_suite)
    end
  end

  def save_test_suite(meta_id, test_report_type, extracted_xml, test_suite)
    test_record_to_be_created = {:time_taken => 0.0, :test_metadatum_id => meta_id, :class_name => test_suite.attr("name"), :number_of_tests => test_suite.attr("tests"),
                                 :number_of_errors => test_suite.attr("errors"), :number_of_failures => test_suite.attr("failures")}
    @doc.xpath("//testsuite/testcase").each do |test_case|
      time = XmlParser.new.get_time(test_case, test_suite, test_report_type)
      test_record_to_be_created[:time_taken] += time.to_f
    end
    saved_test_suite_data = TestSuiteRecord.create_and_save(test_record_to_be_created)
    save_test_case(test_suite, saved_test_suite_data, test_report_type, extracted_xml)

  end

  def save_test_case(test_suite, saved_test_suite_data, test_report_type, extracted_xml)
    if test_report_type == "Rspec JUnit" || test_report_type == "Cucumber JUnit"
      XmlParser.new.saving_junit_test_cases(extracted_xml, saved_test_suite_data, test_report_type, test_suite)
    elsif test_report_type == "Groovy NUnit"
      GroovyNunitParser.parse(extracted_xml, saved_test_suite_data, test_suite)
    end
  end
end

