require 'spec_helper'

describe DefectAnalysisController, type: :controller do
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
      expect(response.code).to eq("200")
    end
  end

  it "should throw error if platform id, date and test category not given" do
    expect { DefectAnalysis.new.get_result_json(nil, nil, "") }.to raise_error
  end

  it "should throw error if platform id not given" do
    expect { DefectAnalysis.new.get_result_json(nil, '2012-02-17'.to_date, "UNIT TEST") }.to raise_error
  end

  it "should throw error if date not given" do
    platform = FactoryGirl.create(:platform)
    expect { DefectAnalysis.new.get_result_json(platform.id, null, "ALL") }.to raise_error
  end
end
