require 'spec_helper'

describe VisualizationController, type: :controller do
  describe "GET 'pyramid'" do
    it "returns http success" do
      get 'pyramid'
      response.should be_success
    end
  end
end
