class Parser
  REPORTTYPE = YAML.load(File.open("#{Rails.root}/config/parser_defs.yml", "r"))

  def parse_test_log_files (input_file_path, output_file_path, meta_datum_id, test_report_type)
    extracted_files =Unzip.copy_and_extract_files(input_file_path, output_file_path)
    test_report_file_type = REPORTTYPE["test_report_type_mapping"][test_report_type.downcase]
    extracted_files.keys.each do |extracted_filename|
      extracted_file_content = extracted_files[extracted_filename]
      parse_file(meta_datum_id, test_report_file_type, test_report_type.downcase, extracted_file_content)
    end
  end

  def parse_file(meta_datum_id, test_report_file_type, test_report_type, extracted_file_content)
    parse_test_run_record_xml(meta_datum_id, test_report_type, extracted_file_content)
    parse_test_run_record_nunit_xml(meta_datum_id, test_report_type, extracted_file_content)
    parse_test_run_record_html(meta_datum_id, test_report_type, extracted_file_content)
    #parse_test_run_record_jasmine(meta_datum_id, test_report_type, extracted_file_content)
  end

  #def parse_test_run_record_jasmine(meta_datum_id, test_report_type, extracted_file_content)
  #  return if (REPORTTYPE["test_report_type_mapping"][test_report_type] != "xml")
  #  #JasmineParser.new.parse(extracted_file_content, meta_datum_id, test_report_type)
  #end

  def parse_test_run_record_nunit_xml(meta_id, test_report_type, extracted_xml)
    return if (REPORTTYPE["test_report_type_mapping"][test_report_type] != "nunit_xml")
    UnitNunitParser.parse(extracted_xml, meta_id)
  end

  def parse_test_run_record_html(meta_id, test_report_type, extracted_html)
    return if (REPORTTYPE["test_report_type_mapping"][test_report_type] != "html")
    if test_report_type == "cucumber_html"
      CucumberHtmlParser.parse(meta_id,extracted_html)
    end
  end

  def parse_test_run_record_xml(meta_id, test_report_type, extracted_xml)
    return if (REPORTTYPE["test_report_type_mapping"][test_report_type] != "xml")
    @doc = Nokogiri::XML extracted_xml
    test_suites_xml = @doc.xpath("//testsuite")
    test_suites_xml.each do |test_suite_xml|
      save_test_suite(meta_id, test_report_type, test_suite_xml)
    end
  end

  def save_test_suite(meta_id, test_report_type, test_suite_xml)
    test_record_to_be_created = {:time_taken => 0.0, :test_metadatum_id => meta_id, :class_name => test_suite_xml.attr("name"), :number_of_tests => test_suite_xml.attr("tests"),
                                 :number_of_errors => test_suite_xml.attr("errors"), :number_of_failures => test_suite_xml.attr("failures")}
    test_cases_to_be_created = []
    test_suite_xml.search(".//testcase").each do |test_case_xml|
      test_record_to_be_created[:time_taken] +=  XmlParser.new.get_time(test_case_xml, test_suite_xml, test_report_type)
      test_cases_to_be_created << XmlParser.new.create_test_case(test_case_xml, test_report_type)
    end
    saved_test_suite_data = TestSuiteRecord.create_and_save(test_record_to_be_created)
    test_cases_to_be_created.each do |each_test_case|
      each_test_case.test_suite_record_id= saved_test_suite_data.id
      each_test_case.save
    end
  end

  #def save_test_case(test_suite_xml, saved_test_suite_data, test_report_type, extracted_xml)
  #  if test_report_type == "junit" || test_report_type == "cucumber junit"
  #    XmlParser.new.saving_junit_test_cases(extracted_xml, test_suite_xml,test_report_type,saved_test_suite_data)
  #  elsif test_report_type == "groovy nunit"
  #    GroovyNunitParser.parse(extracted_xml, saved_test_suite_data, test_suite_xml)
  #  end
  #end
end

