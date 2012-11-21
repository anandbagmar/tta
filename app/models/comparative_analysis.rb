class ComparativeAnalysis
  # To change this template use File | Settings | File Templates.
  def self.getProjectData number_of_tests
    @project_data = JunitXmlDatum.select("tests, failures").inject([]) {|result, record|
      result << [record.tests.to_i, record.failures.to_i] if record.tests && record.failures
      result
    }
  end
end