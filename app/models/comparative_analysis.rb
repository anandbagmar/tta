

class ComparativeAnalysis


  def self.getPercentageOfPassingTests
    @total_num_of_tests = 0
    @number_of_failures = 0
    0.upto(TestRecord.find_all_by_project_metadatum_id("1").length - 1) do |i|
      @total_num_of_tests = @total_num_of_tests + TestRecord.select("number_of_tests").where(project_metadatum_id: Project.first)[i].number_of_tests.to_i
      @number_of_failures = @number_of_failures + TestRecord.select("number_of_failures").where(project_metadatum_id: Project.first)[i].number_of_failures.to_i
    end

    0.upto(ProjectMetadatum.find_all_by_project_id("1").length - 1) do |i|
    @percentage_of_passing_tests =  TestRecord.select("number_of_tests,number_of_failures").where(project_metadatum_id: Project.first).inject([]) {|result, record|
              result << [(ProjectMetadatum.find_all_by_project_id("1")[i].date_of_execution.to_time.to_f * 1000), (@total_num_of_tests.to_f - @number_of_failures.to_f) / @total_num_of_tests.to_f  * 100]
              result
            }
    end

    p "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
     p @percentage_of_passing_tests

    @percentage_of_passing_tests
  end

end