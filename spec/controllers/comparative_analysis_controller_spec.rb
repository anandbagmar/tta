require 'spec_helper'


describe ComparativeAnalysisController do

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      expect(response).to be_success
      expect(response.code).to eq("200")
    end
  end

  it "should return result set" do
    project = FactoryGirl.create(:project)
    sub_project = FactoryGirl.create(:sub_project, :project_id => project.id)
    test_metadata = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id)
    test_suite = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata.id)
    result = ComparativeAnalysis.get_result_set(project.id,"2013-01-01","2013-02-28")
    result.should_not be_empty
    assert_equal result,{"TTA_subProject"=>[[1361318400000.0, 60.0]]}
  end

  it "should throw error if project id not given" do
  expect{ComparativeAnalysis.get_result_set(nil,"2012-1-1","2012-12-12")}.to raise_error
  end

  it"should throw error if start_date not given" do
    expect{ComparativeAnalysis.get_result_set(1,nil,"2012-12-12")}.to raise_error
  end

  it "should throw error if start_date greater than end_date" do
    project = FactoryGirl.create(:project)

    start_date = '2012-12-12'
    end_date = '2010-12-12'

    post :date_filter , :project => {:id => project.id},:comparative_analysis => {:start_date => start_date,:end_date => end_date}
    assert_response :success
    @controller.expects(:create)
    assert_not_nil assigns(@json)
    assert_not_nil flash[:date_error]
    assert_equal flash[:date_error],"select end date greater than start date"

  end

  it "should throw error if start_date is equal to end_date" do
    project = FactoryGirl.create(:project)

    start_date = '2012-12-12'
    end_date = '2012-12-12'

    post :date_filter , :project => {:id => project.id},:comparative_analysis => {:start_date => start_date,:end_date => end_date}
    assert_response :success
    @controller.expects(:create)
    assert_not_nil assigns(@json)
    assert_not_nil flash[:date_error]
    assert_equal flash[:date_error],"select end date greater than start date"


  end

  it "should throw error if there is no data within the date range " do
    project = FactoryGirl.create(:project)
    sub_project = FactoryGirl.create(:sub_project,:project_id => project.id)
    test_metadata = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id)
    test_suite = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata.id)

    start_date = '2013-01-01'
    end_date = '2013-01-31'

    post :date_filter , :project => {:id => project.id},:comparative_analysis => {:start_date => start_date,:end_date => end_date}
    assert_response :success
    @controller.expects(:create)
    assert_not_nil assigns(@json)

    assert_not_nil flash[:no_data_error]
    assert_equal flash[:no_data_error],"No Data between the Date Range "+start_date+" To "+end_date
  end
end
