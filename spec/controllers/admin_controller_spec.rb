require 'spec_helper'

describe AdminController, type: :controller do
  context "GET 'admin'" do
    it "returns http success" do
      get 'view'
      response.should be_success
    end
  end
end
