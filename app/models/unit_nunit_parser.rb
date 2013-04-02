class UnitNunitParser
  def self.parse(config_xml, meta_id)
    @doc = Nokogiri::XML config_xml
    @doc.xpath("//test-suite/results/test-case/../..").each do |test_suite|
      initialize()
      @hash[:time_taken] = test_suite.attr("time").to_f
      @hash[:test_metadatum_id] = meta_id
      suite_name = test_suite.attr("name")
      @hash[:class_name]= test_suite.attr("name")
      @hash[:number_of_failures] = @doc.xpath("//test-results").attr("failures")
      @doc.xpath("//test-suite[@name='#{suite_name}']/results/test-case").each do |test_case|
        save_test_case_records(suite_name, test_case)
      end
    end
    return
  end

  def self.initialize
    @hash[:number_of_tests] = 0
    @hash[:number_of_errors] = 0
    @hash[:number_of_tests_ignored] = 0
    @hash[:number_of_tests_not_run] =0
  end

  def self.save_test_case_records(suite_name, test_case)
    @xml_test_case = TestCaseRecord.new()
    class_name = test_case.attr("name")
    @xml_test_case.class_name = test_case.attr("name")
    @xml_test_case.time_taken = test_case.attr("time")
    calculate_tests_count_summary(class_name, suite_name, test_case)
    @xml_test_case.test_suite_record_id = TestSuiteRecord.create_and_save(@hash).id
    @xml_test_case.save
  end

  def self.calculate_tests_count_summary(class_name, suite_name, test_case)
    @hash[:number_of_tests]+= 1
    if test_case.attr("results")=="ignored"
      @hash[:number_of_tests_ignored] += 1
    end
    if test_case.attr("executed")=="False"
      @hash[:number_of_tests_not_run] += 1
    else
      if test_case.attr("success") == "False"
        @hash[:number_of_errors] +=1
        @xml_test_case.error_msg = @doc.xpath("//test-suite[@name='#{suite_name}']/results/test-case[@name='#{class_name}']/failure").text
      end
    end
  end
end