class Visualization

  def self.getResultJson(sub_project_id)
    getAllFields(sub_project_id)
    test_types=[]
    @test_types.zip(@percent_of_tests, @duration_of_tests).each do |test_type, percent_of_test, duration_of_test|
      test_types <<
        {
          :test_name => test_type.test_category,
          :percent => percent_of_test,
          :duration => duration_of_test
        }
    end

    @json = {
      :sub_project_name => SubProject.find(sub_project_id, :select => "name").name,
      :test_types => test_types.sort_by{|test_type|test_type[:percent]}
    }.to_json
    return @json
  end

  private
  def self.getAllFields(sub_project_id)
    @test_types = TestMetadatum.get_distinct_test_category(sub_project_id)
    result =[]
    @test_types.each do |test_type|
      result << getNoOfTests(sub_project_id, test_type.test_category)
    end
    @percent_of_tests, @duration_of_tests=calculatePercentageAndDuration(result)
  end

  def self.getNoOfTests(sub_project_id, test_type)
    result = SubProject.get_data_for_test_category(sub_project_id,test_type)
    result
  end

  def self.calculatePercentageAndDuration(result)
    no_of_tests=[]; duration_of_tests=[]; percentOfTests=[];
    total=0.0
    result.each do |test_type_result|
      no_of_test_of_test_type = 0
      duration_of_test_of_test_type =0.0
      test_type_result.each do |test_type|
        no_of_test_of_test_type += test_type[0]
        duration_of_test_of_test_type += (test_type[1].to_f)/1000
      end
      duration_of_tests<<"%0.6f" %(duration_of_test_of_test_type)
      no_of_tests << no_of_test_of_test_type
    end
    no_of_tests.each do |entry|
      total += entry
    end
    no_of_tests.each do |entry|
      percentOfTests << "%0.2f" %((entry.to_f/total)*100)
    end
    return percentOfTests, duration_of_tests
  end
end