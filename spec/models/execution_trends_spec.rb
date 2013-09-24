require "rspec"

describe "Execution Trends" do
  context "get class names" do
    it "should return a list of class names for selected filters " do
      project= FactoryGirl.create(:project)
      sub_project= FactoryGirl.create(:sub_project, project: project)
      metadata= FactoryGirl.create(:test_metadatum, sub_project_id: sub_project.id, date_of_execution: Date.today)
      suite_record= FactoryGirl.create(:test_suite_records, test_metadatum: metadata)
      case_record= FactoryGirl.create(:test_case_record, test_suite_record: suite_record)
      TestMetadatum.should_receive(:where).and_call_original
      TestSuiteRecord.should_receive(:where).and_call_original
      TestCaseRecord.should_receive(:where).and_call_original
      result = ExecutionTrends.new.get_class_names(sub_project.id,metadata.test_category,Date.yesterday.to_s,Date.today.to_s)
      result.count == 1
      (result.map(&:class_name).include? case_record.class_name) == true
    end
  end


end
