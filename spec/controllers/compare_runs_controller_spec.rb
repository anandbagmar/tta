require 'spec_helper'

describe CompareRunsController, type: :controller do
  context "GET 'comapre_runs'" do

    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end
end
