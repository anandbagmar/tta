

class ComparativeAnalysis


  

  def self.getPercentageOfPassingTests(project_id,start_date="1900-01-01",end_date="2200-12-31")


    @percentage_of_passing_tests = ProjectMetadatum.where(:project_id => project_id,:date_of_execution => start_date..end_date).inject([]) {|result, record|
        total_num_of_tests = 0
        number_of_failures = 0
        TestRecord.find_all_by_project_metadatum_id(record.id).each do |test|
          total_num_of_tests += test.number_of_tests.to_i
          number_of_failures += test.number_of_failures.to_i

        end
        result << [(record.date_of_execution.to_time.to_f * 1000), (total_num_of_tests.to_f - number_of_failures.to_f) / total_num_of_tests.to_f  * 100]
    }

    @percentage_of_passing_tests
  end



end