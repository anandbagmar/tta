class Visualization

  def self.getResultJson(sub_project_id)
    get_latest_metadata_record(sub_project_id)
    test_types=[]
    puts @test_category
    puts @percent_of_tests
    puts @duration_of_tests
    @test_category.zip(@percent_of_tests, @duration_of_tests, @no_of_test_in_test_category).each do |test_category, percent_of_test, duration_of_test, no_of_test|
      test_types <<
        {
          :test_name => test_category,
          :percent => percent_of_test,
          :duration => duration_of_test,
          :test_no => no_of_test
        }
    end

    @json = {
      :sub_project_name => SubProject.find(sub_project_id, :select => "name").name,
      :test_types => test_types.sort_by{|test_type|test_type[:percent]}
    }.to_json
    return @json
  end


  private
  def self.get_latest_metadata_record(sub_project_id)
    @test_metadata_records_for_latest_run = []
    @no_of_test_in_test_category =[]
    @duration_of_test_in_Test_category=[]
    @total=0
    get_record_with_distinct_test_category(sub_project_id)

    @test_category.each do |test_category|
      @test_metadata_records_for_latest_run << TestMetadatum.get_latest_record(sub_project_id,test_category)
    end

    @test_metadata_records_for_latest_run.each do |record|
      no_of_tests,duration_of_test = TestMetadatum.find_no_and_duration_of_test(record)
      @total+=no_of_tests
      @no_of_test_in_test_category << no_of_tests
      @duration_of_test_in_Test_category << duration_of_test
    end
      @percent_of_tests, @duration_of_tests = calculatePercentageAndDuration(@no_of_test_in_test_category,@duration_of_test_in_Test_category,@total)
  end


  def self.get_record_with_distinct_test_category(sub_project_id)
    metadata_with_distinct_test_category = TestMetadatum.get_distinct_test_category(sub_project_id)
    @test_category=[]
    metadata_with_distinct_test_category.each do |test_type|
      @test_category << test_type.test_category
    end
  end

  def self.calculatePercentageAndDuration(no_of_test_in_test_category,duration_of_test_in_test_category,total_no_of_tests)
    percent = []
    duration = []
    no_of_test_in_test_category.zip(duration_of_test_in_test_category).each do |no_of_test , duration_of_test|
      duration_of_tests="%0.6f" %((duration_of_test.to_f)/1000)
      percentOfTests = "%0.2f" %((no_of_test.to_f/total_no_of_tests)*100)
      percent << percentOfTests
      duration << duration_of_tests
    end
    return percent , duration
  end

end
