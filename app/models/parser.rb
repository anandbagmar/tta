class Parser
  REPORTTYPE = YAML.load(File.open("#{Rails.root}/config/parser_defs.yml", "r"))

  def parse_test_log_files (input_file_path, output_file_path, meta_datum_id, test_report_type)
    test_report_file_type = REPORTTYPE["test_report_type_mapping"][test_report_type.downcase]
    # puts "#{REPORTTYPE["test_report_type_mapping"].inspect}"
    # puts "parse_test_log_files: test_report_type: #{test_report_type}, test_report_file_type: #{test_report_file_type}"
    extracted_files       = Unzip.copy_and_extract_files(input_file_path, output_file_path, test_report_file_type)
    extracted_files.keys.each do |extracted_filename|
      # puts "parsing file: #{extracted_filename}"
      extracted_file_content = extracted_files[extracted_filename]
      parse_results_and_update_in_db(meta_datum_id, test_report_file_type, test_report_type.downcase, extracted_file_content)
    end
  end

  def parse_results_and_update_in_db(meta_datum_id, test_report_file_type, test_report_type, extracted_file_content)
    parse_test_run_record_junit_xml(meta_datum_id, test_report_type, extracted_file_content)
    parse_test_run_record_nunit_xml(meta_datum_id, test_report_type, extracted_file_content)
    parse_test_run_record_html(meta_datum_id, test_report_type, extracted_file_content)
    parse_test_run_record_cucumber_json(meta_datum_id, test_report_type, extracted_file_content)
  end

  def parse_test_run_record_nunit_xml(meta_id, test_report_type, extracted_xml)
    return if (REPORTTYPE["test_report_type_mapping"][test_report_type] != "nunit_xml")
    UnitNunitParser.parse(extracted_xml, meta_id)
  end

  def parse_test_run_record_cucumber_json(meta_id, test_report_type, extracted_json)
    return if (REPORTTYPE["test_report_type_mapping"][test_report_type] != "json")
    CucumberJSONParser.parse(meta_id, extracted_json)
  end

  def parse_test_run_record_html(meta_id, test_report_type, extracted_html)
    return if (REPORTTYPE["test_report_type_mapping"][test_report_type] != "html")
    CucumberHtmlParser.parse(meta_id, extracted_html)
  end

  def parse_test_run_record_junit_xml(meta_id, test_report_type, extracted_xml)
    return if (REPORTTYPE["test_report_type_mapping"][test_report_type] != "xml")
    JunitXmlParser.parse(extracted_xml, meta_id, test_report_type)
  end

end

