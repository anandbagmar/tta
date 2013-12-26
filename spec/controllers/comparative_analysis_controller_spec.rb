require 'spec_helper'


describe ComparativeAnalysisController do

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      expect(response).to be_success
      expect(response.code).to eq("200")
    end
  end

  it "should return result set for all test sub category" do
    project = FactoryGirl.create(:project)
    sub_project = FactoryGirl.create(:sub_project, :project_id => project.id)
    today=Date.yesterday.to_time_in_current_zone
    yesterday=Date.yesterday.to_time_in_current_zone
    test_metadata1 = FactoryGirl.create(:test_metadatum, sub_project_id: sub_project.id, date_of_execution: yesterday)
    test_metadata2 = FactoryGirl.create(:test_metadatum, sub_project_id: sub_project.id, date_of_execution: today, test_category: "FUNCTIONAL TEST", test_sub_category: "REGRESSION TEST")
    test_metadata3 = FactoryGirl.create(:test_metadatum, sub_project_id: sub_project.id, date_of_execution: today, test_category: "FUNCTIONAL TEST", test_sub_category: "SMOKE TEST")
    FactoryGirl.create(:test_suite_records, :test_metadatum_id => test_metadata1.id)
    FactoryGirl.create(:test_suite_records, :test_metadatum_id => test_metadata2.id)
    FactoryGirl.create(:test_suite_records, :test_metadatum_id => test_metadata3.id)
    result = ComparativeAnalysis.new.get_result_set(project.id,sub_project.id, nil, Date.yesterday.to_date, Date.today.to_date)
    result.should_not be_empty
    assert_equal result, {"TTA_subProject"=>{"UNIT TEST : UNIT TEST" => [[yesterday.to_time.to_f*1000, 60.0]], "FUNCTIONAL TEST : REGRESSION TEST" => [[today.to_time.to_f*1000, 60.0]], "FUNCTIONAL TEST : SMOKE TEST" => [[today.to_time.to_f*1000, 60.0]]}}
  end

  it "should return result set for selected test sub category" do
    project = FactoryGirl.create(:project)
    sub_project = FactoryGirl.create(:sub_project, :project_id => project.id)
    today=Date.yesterday.to_time_in_current_zone
    yesterday=Date.yesterday.to_time_in_current_zone
    test_metadata1 = FactoryGirl.create(:test_metadatum, sub_project_id: sub_project.id, date_of_execution: yesterday)
    test_metadata2 = FactoryGirl.create(:test_metadatum, sub_project_id: sub_project.id, date_of_execution: today, test_category: "FUNCTIONAL TEST", test_sub_category: "REGRESSION TEST")
    test_metadata3 = FactoryGirl.create(:test_metadatum, sub_project_id: sub_project.id, date_of_execution: today, test_category: "FUNCTIONAL TEST", test_sub_category: "SMOKE TEST")
    FactoryGirl.create(:test_suite_records, :test_metadatum_id => test_metadata1.id)
    FactoryGirl.create(:test_suite_records, :test_metadatum_id => test_metadata2.id)
    FactoryGirl.create(:test_suite_records, :test_metadatum_id => test_metadata3.id)
    result = ComparativeAnalysis.new.get_result_set(project.id,sub_project.id, ["REGRESSION TEST","SMOKE TEST"], Date.yesterday.to_date, Date.today.to_date)
    result.should_not be_empty
    assert_equal result, {"TTA_subProject"=>{"FUNCTIONAL TEST : REGRESSION TEST" => [[today.to_time.to_f*1000, 60.0]], "FUNCTIONAL TEST : SMOKE TEST" => [[today.to_time.to_f*1000, 60.0]]}}
  end

  describe "Get 'test_category_mapping_list'" do
    it "should return a list of test category and test sub category" do
      sub_project = FactoryGirl.create(:sub_project)
      test_metadata1 = FactoryGirl.create(:test_metadatum, sub_project_id: sub_project.id, date_of_execution: Date.yesterday.to_time_in_current_zone)
      test_metadata2 = FactoryGirl.create(:test_metadatum, sub_project_id: sub_project.id, date_of_execution: Date.today.to_time_in_current_zone, test_category: "FUNCTIONAL TEST", test_sub_category: "REGRESSION TEST")
      test_metadata3 = FactoryGirl.create(:test_metadatum, sub_project_id: sub_project.id, date_of_execution: Date.today.to_time_in_current_zone, test_category: "FUNCTIONAL TEST", test_sub_category: "SMOKE TEST")
      get :test_category_mapping_list, {sub_project_id: sub_project.id, comparative_analysis_start_date: Date.yesterday, comparative_analysis_end_date: Date.today}
      response.should be_success
      response.body.should == "[\"UNIT TEST\",\"REGRESSION TEST\",\"SMOKE TEST\"]"
    end
  end

  it "should throw error if project id not given" do
    expect { ComparativeAnalysis.new.get_result_set(nil,nil, nil, "2012-1-1".to_date, "2012-12-12".to_date) }.to raise_error
  end

  it "should throw error if start_date not given" do
    expect { ComparativeAnalysis.new.get_result_set(1,1, nil, nil, "2012-12-12".to_date) }.to raise_error
  end

  it "should throw error if there is no data within the date range " do
    project = FactoryGirl.create(:project)
    sub_project = FactoryGirl.create(:sub_project, :project_id => project.id)
    test_metadata = FactoryGirl.create(:test_metadatum, :sub_project_id => sub_project.id)
    FactoryGirl.create(:test_suite_records, :test_metadatum_id => test_metadata.id)

    start_date = '2013-01-01'
    end_date = '2013-01-31'

    post :date_filter, :project_id => project.id, :comparative_analysis => {:start_date => start_date, :end_date => end_date}, :sub_project_id => sub_project.id
    assert_response :success
    @controller.expects(:create)
    assert_not_nil assigns(@json)
    assert_not_nil flash[:no_data_error]
    assert_equal flash[:no_data_error], "No Data between the Date Range "+start_date+" To "+end_date
  end
end
