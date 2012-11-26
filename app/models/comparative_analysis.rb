class ComparativeAnalysis
  def self.getProjectData1
    @project_data = TestRecord.select("number_of_tests, number_of_failures").where(project_metadatum_id: 1).inject([]) {|result, record|
      result << [record.number_of_tests.to_i, record.number_of_failures.to_i] if record.number_of_tests && record.number_of_failures
      result
    }
  end
  def self.getProjectData2
    @project_data = TestRecord.select("number_of_tests, number_of_failures").where(project_metadatum_id: 2).inject([]) {|result, record|
      result << [record.number_of_tests.to_i, record.number_of_failures.to_i] if record.number_of_tests && record.number_of_failures
      result
    }
  end
end