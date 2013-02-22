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
    result = ComparativeAnalysis.get_result_set(project.id,"2012-01-01","2012-12-12")
    result.should_not be_nil
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

  end
end
