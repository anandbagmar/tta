class CucumberHtmlParser
  def self.parse(meta_id, extracted_html)
    @parsed_html = Nokogiri::HTML extracted_html
    test_suite_id=save_test_suite(meta_id)
    save_test_case_record(test_suite_id)
  end

  def self.save_test_suite(meta_id)
    feature_name                    = @parsed_html.css('.feature .val')
    test_suite_name                 =feature_name.children[0].to_s.split('Feature:')
    html_handle                     = @parsed_html.xpath("//script")
    total_failure, total_test       =count_number_of_test_passed_and_failed(html_handle)
    total_run_time                  =find_test_duration(html_handle)
    test_suite_record_to_be_created = { :test_metadatum_id => meta_id, :class_name => test_suite_name[1],
                                        :number_of_tests   => total_test, :number_of_failures => total_failure, :time_taken => total_run_time.to_s }
    return TestSuiteRecord.create_and_save(test_suite_record_to_be_created).id
  end

  def self.count_number_of_test_passed_and_failed(html_handle)
    html_handle.each do |node|
      if node.to_s.index("document.getElementById('totals')")
        test_statistics    = node.inner_html
        failed_tests_count = find_failure_count(test_statistics)
        total_tests_count  = find_total_test_count(test_statistics)
        return failed_tests_count.to_i, total_tests_count.to_i
      end
    end
  end

  def self.find_total_test_count(test_statistics)
    if test_statistics.to_s.include?("scenario")
      total_test_count = test_statistics.scan(/\"([^"]+)/).first.first.scan(/\d+/).first
    else
      total_test_count = "0"
    end
    total_test_count
  end

  def self.find_failure_count(test_statistics)
    number_of_failing_and_passing_tests = test_statistics.scan(/\(([^()]+)\)/).last.last
    if number_of_failing_and_passing_tests.include?("failed")
      number_of_failing_tests=number_of_failing_and_passing_tests.scan(/\d+/).first
    else
      number_of_failing_tests="0"
    end
    number_of_failing_tests
  end

  def self.find_test_duration(html_handle)
    html_handle.each do |node|
      if node.to_s.index("document.getElementById('duration')")
        test_run_time = node.inner_html.scan(/<strong[^>]*>(.*?)<\/strong>/).first.first.scan(/[.\d]+/)
        test_run_time = test_run_time[1].to_f+((test_run_time[0].to_f)*60)
        return test_run_time
      end
    end
  end

  def self.save_test_case_record(test_suite_id)
    scenario_link=@parsed_html.css('.scenario')
    scenario_link.each do |link|
      @html_test_case                     =TestCaseRecord.new()
      @html_test_case.test_suite_record_id=test_suite_id
      @html_test_case.class_name          = link.css('.val').children[0].to_s
      @html_test_case.error_msg           = link.css('.message').children.children.to_s + link.css('.backtrace').children.children.to_s
      @html_test_case.error_msg           = @html_test_case.error_msg.gsub("\"", "'")
      @html_test_case.save
    end
  end
end
