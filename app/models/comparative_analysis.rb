class ComparativeAnalysis
  # To change this template use File | Settings | File Templates.
  def self.getProjectData number_of_tests
    @project_data = TestRecord.select("number_of_tests, number_of_failures").inject([]) {|result, record|
      result << [record.number_of_tests.to_i, record.number_of_failures.to_i] if record.number_of_tests && record.number_of_failures
      result
    }
  end
end