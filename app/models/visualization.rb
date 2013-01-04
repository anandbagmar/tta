class Visualization

  def self.getNoOfTests(sub_project_id,test_type)

    meta_data = SubProject.find(sub_project_id).test_metadatum.find_all_by_test_category(test_type)

    meta_data.inject([]){ |result, metadata_record|
      total_num_of_tests = 0
      total_run_time = 0
      metadata_record.test_suite_records.each do |test_suite_record|
        total_num_of_tests += test_suite_record.number_of_tests.to_i
        total_run_time += test_suite_record.time_taken.to_i
      end

      result << [total_num_of_tests,total_run_time]


    }

  end




end