require 'spec_helper'

describe DefectAnalysisController, type: :controller do
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
      expect(response.code).to eq("200")
    end
  end

  it"should throw error if sub_project id, date and test category not given" do
    expect{DefectAnalysis.new.get_result_json(nil,nil,"")}.to raise_error
  end

  it"should throw error if sub_project id not given" do
    expect{DefectAnalysis.new.get_result_json(nil,'2012-02-17'.to_date,"UNIT TEST")}.to raise_error
  end

  it"should throw error if date not given" do
    sub_project = FactoryGirl.create(:sub_project)
    expect{DefectAnalysis.new.get_result_json(sub_project.id,null,"ALL")}.to raise_error
  end
end
