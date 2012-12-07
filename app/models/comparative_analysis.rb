

class ComparativeAnalysis

  def self.getPercentageOfPassingTests(sub_project_id, start_date="1900-01-01",end_date="2200-12-31")

    meta_data = SubProject.find(sub_project_id).test_metadatum.find_all_by_date_of_execution(start_date..end_date)
    meta_data.inject([]){ |result, metadata_record|
      total_num_of_tests = 0
      number_of_failures = 0
      metadata_record.test_records.each do |test_record|
        total_num_of_tests += test_record.number_of_tests.to_i
        number_of_failures += test_record.number_of_failures.to_i
      end
      result << [(metadata_record.date_of_execution.to_time.to_f * 1000), (total_num_of_tests.to_f - number_of_failures.to_f) / total_num_of_tests.to_f  * 100]
    }
  end

end