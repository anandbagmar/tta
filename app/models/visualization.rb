class Visualization
  TESTTYPE = YAML.load(File.open("#{Rails.root}/config/test_types.yml", "r"))

  def getResultJson(platform_id)
    @HIGH_PRIORITY_SEQUENCE = 1000
    get_latest_metadata_record(platform_id)
    unknown_test_types=[]
    test_types=[]
    @test_category.zip(@percent_of_tests, @duration_of_tests, @no_of_test_in_test_category, @passing_test_percentage).each do |test_category, percent_of_test, duration_of_test, no_of_test, passing_percentage|
      if !(TESTTYPE[test_category].nil?)
        test_types <<
            {
                :test_name => test_category,
                :seq_no => TESTTYPE[test_category],
                :percent => percent_of_test,
                :duration => duration_of_test,
                :no_of_test => no_of_test,
                :percentage_passing => passing_percentage
            }

      else
        unknown_test_types.push(test_category)
      end
    end
    @json = {
        :platform_name => Platform.find(platform_id).name,
        :test_types => test_types.sort_by { |test_type| test_type[:seq_no] },
        :unknown_test_types => (unknown_test_types if unknown_test_types!=[])
    }.to_json
    return @json
  end

  def get_latest_metadata_record(platform_id)
    @test_metadata_records_for_latest_run = []
    @no_of_test_in_test_category =[]
    @no_of_failure_in_test_category=[]
    @duration_of_test_in_Test_category=[]
    @total=0
    failure_count=0
    get_record_with_distinct_test_category(platform_id)

    @test_category.each do |test_category|
      @test_metadata_records_for_latest_run << TestMetadatum.new.get_latest_record(platform_id, test_category)
    end

    @test_metadata_records_for_latest_run.each do |record|
      no_of_tests, duration_of_test, failure_count = TestMetadatum.new.find_no_and_duration_of_test(record)
      @total+=no_of_tests
      @no_of_test_in_test_category << no_of_tests
      @duration_of_test_in_Test_category << duration_of_test
      @no_of_failure_in_test_category << failure_count
    end
    @percent_of_tests, @duration_of_tests, @passing_test_percentage = calculatePercentageAndDuration(@no_of_test_in_test_category, @duration_of_test_in_Test_category, @total, @no_of_failure_in_test_category)
  end


  def get_record_with_distinct_test_category(platform_id)
    @test_category = TestMetadatum.new.get_distinct_test_category(platform_id)
  end

  def calculatePercentageAndDuration(no_of_test_in_test_category, duration_of_test_in_test_category, total_no_of_tests, failure_count)
    percent = []
    duration = []
    percent_passing = []
    no_of_test_in_test_category.zip(duration_of_test_in_test_category, failure_count).each do |no_of_test, duration_of_test, failure|
      percentOfTests = "%0.2f" %((no_of_test.to_f/total_no_of_tests)*100)
      passing_percent = "%0.2f" %(((no_of_test.to_f-failure.to_f)/no_of_test.to_f)*100)
      percent << percentOfTests
      duration << duration_of_test
      percent_passing << passing_percent
    end
    return percent, duration, percent_passing
  end
end
