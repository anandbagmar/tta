class ComparativeAnalysis
  # To change this template use File | Settings | File Templates.
  def self.getProjectData number_of_tests
    @project_data = TestRecord.select("number_of_tests, number_of_failures").inject([]) {|result, record|
      result << [record.tests.to_i, record.failures.to_i] if record.tests && record.failures
      result
    }
  end
end