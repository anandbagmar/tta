class CucumberHtmlParser
  def self.parse(config_html, meta_id)
    @doc_html = Nokogiri::HTML config_html
    test_suite_id=save_test_suite(meta_id)
    save_test_case_record(test_suite_id)
  end

  def self.save_test_suite(meta_id)
    link= @doc_html.css('.feature .val')
    test_suite_name=link.children[0].to_s.split('Feature:')
    script_div = @doc_html.xpath("//script")
    total_test, total_failure=find_count_summary(script_div)
    total_run_time=find_test_duration(script_div)
    hash = {:test_metadatum_id => meta_id, :class_name => test_suite_name[1],
            :number_of_tests => total_test, :number_of_failures => total_failure, :time_taken => total_run_time.to_s}
    return TestSuiteRecord.create_and_save(hash).id
  end

  def self.find_count_summary(script_div)
    script_div.each do |script_div_link|
      if script_div_link.to_s.index("document.getElementById('totals')")
        totals_contents = script_div_link.inner_html
        failed_tests_count = find_failure_count(totals_contents)
        total_tests_count = find_total_test_count(totals_contents)
        return failed_tests_count.to_i, total_tests_count.to_i
      end
    end
  end

  def self.find_total_test_count(totals_contents)
    if totals_contents.to_s.include?("scenario")
      starting_position = totals_contents.index("=")+3
      end_position = totals_contents.index("scenario")-1
    else
      starting_position = totals_contents.index("=")+3
      end_position = totals_contents.index("scenarios")-1
    end
    totals_contents[starting_position..end_position].strip
  end

  def self.find_failure_count(totals_contents)
    starting_position = totals_contents.index("(", totals_contents.rindex("=")+1)+1
    if totals_contents.to_s.include?("failed")
      end_position = totals_contents.index("failed")-1
      failed_tests_count = totals_contents[starting_position..end_position].strip
    end
    failed_tests_count
  end

  def self.find_test_duration(script_div)
    script_div.each do |script_div_link|
      if script_div_link.to_s.index("document.getElementById('duration')")
        duration_contents = script_div_link.inner_html
        starting_position = duration_contents.index("<strong>")+8
        end_position = duration_contents.index("seconds")-1
        test_run_time = duration_contents[starting_position..end_position].strip.split('m')
        test_run_time= test_run_time[1].to_f+((test_run_time[0].to_f)*60)
        return test_run_time
      end
    end
  end

  def self.save_test_case_record(test_suite_id)
    scenario_link=@doc_html.css('.scenario')
    scenario_link.each do |link|
      @html_test_case=TestCaseRecord.new()
      @html_test_case.test_suite_record_id=test_suite_id
      @html_test_case.class_name = link.css('.val').children[0].to_s
      @html_test_case.error_msg= link.css('.message').children.children.to_s + link.css('.backtrace').children.children.to_s
      @html_test_case.error_msg= @html_test_case.error_msg.gsub("\"", "'")
      @html_test_case.save
    end
  end
end
