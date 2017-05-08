require "rspec"

describe "Execution Trends" do
  context "get class names" do
    it "should return a list of class names for selected filters " do
      product     = FactoryGirl.create(:product)
      platform    = FactoryGirl.create(:platform, product: product)
      metadata    = FactoryGirl.create(:test_metadatum, platform_id: platform.id, date_of_execution: Date.today, branch: "master")
      suite_record= FactoryGirl.create(:test_suite_records, test_metadatum: metadata)
      case_record = FactoryGirl.create(:test_case_record, test_suite_record: suite_record)
      TestMetadatum.should_receive(:where).and_call_original
      TestSuiteRecord.should_receive(:where).and_call_original
      TestCaseRecord.should_receive(:where).and_call_original
      result = ExecutionTrends.new.get_class_names(platform.id, metadata.test_category, Date.yesterday.to_s, Date.today.to_s)
      result.count == 1
      (result.map(&:class_name).include? case_record.class_name) == true
    end
  end

  context "get result set" do
    it "should return a list of class names for selected filters " do
      time_taken = [[1234567890.000, 0.01234]]
      class_name = "UNIT TEST"
      ExecutionTrends.any_instance.should_receive(:get_time_taken).and_return([time_taken, 1.01234])
      Platform.should_receive(:get_platform_name).and_return("TTA Project")
      result = ExecutionTrends.new.get_result_set("1", class_name, Date.yesterday.to_s, Date.today.to_s)
      result.should == [{ "TTA Project" => { class_name => time_taken } }, 1.01234]
    end
  end

  context "get time taken" do
    it "should return a list of class names for selected filters " do
      product     = FactoryGirl.create(:product)
      platform    = FactoryGirl.create(:platform, product: product)
      metadata    = FactoryGirl.create(:test_metadatum, platform_id: platform.id, date_of_execution: Date.today.to_time, branch: "master")
      suite_record= FactoryGirl.create(:test_suite_records, test_metadatum: metadata)
      case_record = FactoryGirl.create(:test_case_record, test_suite_record: suite_record)
      TestCaseRecord.should_receive(:where).and_call_original
      TestSuiteRecord.should_receive(:where).and_call_original
      TestMetadatum.should_receive(:where).and_call_original
      result, max_val = ExecutionTrends.new.get_time_taken(case_record.class_name, Date.yesterday.to_s, Date.today.to_s)
      result.count == 1
      result.should ==[[Date.today.to_time.to_f * 1000, 5.0]]
      max_val.should == 6.0
    end
  end
end
