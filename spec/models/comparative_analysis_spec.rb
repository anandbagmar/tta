require "rspec"

describe ComparativeAnalysis do

  it "should return result set" do
    product = FactoryGirl.create(:product)
    platform = FactoryGirl.create(:platform, :product_id => product.id)
    result = ComparativeAnalysis.new.get_result_set(product.id,platform.id, nil, "1990-1-1", "2012-12-12")
    result.should_not be_nil
  end

  it "should throw error if platform id not given" do
    expect { ComparativeAnalysis.new.get_result_set(nil,nil, nil, nil, nil) }.to raise_error
  end

  it "should return result set with a single point if product has only one build between the date range" do
    product = FactoryGirl.create(:product)
    platform = FactoryGirl.create(:platform, :product_id => product.id)
    test_metadata = FactoryGirl.create(:test_metadatum, :platform_id => platform.id, :branch => "master")
    test_suite_record = FactoryGirl.create(:test_suite_records, :test_metadatum_id => test_metadata.id)
    FactoryGirl.create(:test_case_record, :test_suite_record_id => test_suite_record.id)

    result = ComparativeAnalysis.new.get_result_set(product.id,platform.id, nil, "2013-01-01".to_date, "2013-03-30".to_date)
    result["TTA_PLATFORM"]["UNIT TEST : UNIT TEST"].count.should eq(1)
  end

  it "should return the result set with points in increasing order of the date of execution" do
    product = FactoryGirl.create(:product)
    platform = FactoryGirl.create(:platform, :product_id => product.id)
    test_metadata_3 = FactoryGirl.create(:test_metadatum, :platform_id => platform.id, :date_of_execution => "2013-01-10", :branch => "master")
    test_metadata_2 = FactoryGirl.create(:test_metadatum, :platform_id => platform.id, :date_of_execution => "2013-01-16", :branch => "master")
    test_metadata_1 = FactoryGirl.create(:test_metadatum, :platform_id => platform.id, :branch => "master")

    test_suite_record_1 = FactoryGirl.create(:test_suite_records, :test_metadatum_id => test_metadata_1.id)
    test_suite_record_2 = FactoryGirl.create(:test_suite_records, :test_metadatum_id => test_metadata_2.id)
    test_suite_record_3 = FactoryGirl.create(:test_suite_records, :test_metadatum_id => test_metadata_3.id)

    FactoryGirl.create(:test_case_record, :test_suite_record_id => test_suite_record_1.id)
    FactoryGirl.create(:test_case_record, :test_suite_record_id => test_suite_record_2.id)
    FactoryGirl.create(:test_case_record, :test_suite_record_id => test_suite_record_3.id)

    test_metadata_list = [test_metadata_1, test_metadata_2, test_metadata_3]
    final_result=test_metadata_list.inject([]) { |result1, metadata_record|
      total_num_of_tests = 0
      number_of_failures = 0
      metadata_record.test_suite_records.each do |test_suite_record|
        total_num_of_tests += test_suite_record.number_of_tests.to_i
        number_of_failures += test_suite_record.number_of_failures.to_i
      end
      result1 << [(metadata_record.date_of_execution.to_time.to_f * 1000), (total_num_of_tests.to_f - number_of_failures.to_f) / total_num_of_tests.to_f * 100]
    }
    result = ComparativeAnalysis.new.get_result_set(product.id,platform.id, nil, "2013-01-01".to_date, "2013-03-30".to_date)
    final_result.reverse.should eq(result["TTA_PLATFORM"]["UNIT TEST : UNIT TEST"])
  end

  it "should return result set with different points if tests with different pass % present for same day" do
    product = FactoryGirl.create(:product)
    platform = FactoryGirl.create(:platform, :product_id => product.id)
    test_metadata = FactoryGirl.create(:test_metadatum, :platform_id => platform.id, :branch => "master")
    test_metadata_1 = FactoryGirl.create(:test_metadatum, :platform_id => platform.id, :test_category => "FUNCTIONAL TEST", :branch => "master")
    test_suite_record = FactoryGirl.create(:test_suite_records, :test_metadatum_id => test_metadata.id, :number_of_tests => "20", :number_of_errors => "10")
    test_suite_record_1 = FactoryGirl.create(:test_suite_records, :test_metadatum_id => test_metadata_1.id)
    FactoryGirl.create(:test_case_record, :test_suite_record_id => test_suite_record.id)
    FactoryGirl.create(:test_case_record, :test_suite_record_id => test_suite_record_1.id)

    result = ComparativeAnalysis.new.get_result_set(product.id,platform.id, nil, "2013-01-01".to_date, "2013-03-30".to_date)
    result["TTA_PLATFORM"]["UNIT TEST : UNIT TEST"].count.should eq(1)
    result["TTA_PLATFORM"]["FUNCTIONAL TEST : UNIT TEST"].count.should eq(1)
  end

  it "should return proper result set for valid data" do
    product = FactoryGirl.create(:product)
    platform = FactoryGirl.create(:platform, :product_id => product.id)
    test_metadata = FactoryGirl.create(:test_metadatum, :platform_id => platform.id, :branch => "master")
    test_metadata_1 = FactoryGirl.create(:test_metadatum, :platform_id => platform.id, :date_of_execution => "2013-01-01", :branch => "master")
    test_metadata_2 = FactoryGirl.create(:test_metadatum, :platform_id => platform.id, :date_of_execution => "2013-01-09", :branch => "master")
    test_suite_record = FactoryGirl.create(:test_suite_records, :test_metadatum_id => test_metadata.id)
    test_suite_record_1 = FactoryGirl.create(:test_suite_records, :test_metadatum_id => test_metadata_1.id)
    test_suite_record_2 = FactoryGirl.create(:test_suite_records, :test_metadatum_id => test_metadata_2.id)
    FactoryGirl.create(:test_case_record, :test_suite_record_id => test_suite_record.id)
    FactoryGirl.create(:test_case_record, :test_suite_record_id => test_suite_record_1.id)
    FactoryGirl.create(:test_case_record, :test_suite_record_id => test_suite_record_2.id)

    result = ComparativeAnalysis.new.get_result_set(product.id,platform.id, nil, "2013-01-01".to_date, "2013-03-30".to_date)
    result["TTA_PLATFORM"]["UNIT TEST : UNIT TEST"].count.should eq(3)
  end

end