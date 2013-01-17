require 'spec_helper'

describe VisualizationController do

  describe "GET 'pyramid'" do
    it "returns http success" do
      get 'pyramid'
      response.should be_success
    end
  end


  describe "sub_project_filter" do
    it "assign flash error message for invalid id" do

      post :sub_project_filter, :sub_project => {:id => 100000}

      assert_response :success
      @controller.expects(:sub_project_filter)
      assert_equal flash[:no_id_error],"No Sub-Project Selected"
    end

    it "assigns flash error message if sub_project_id is blank" do
      post :sub_project_filter , :sub_project => {:id => ""}

      assert_response :success
      @controller.expects(:sub_project_filter)
      assert_equal flash[:no_id_error] , "No Sub-Project Selected"
    end

    it "expects flash error message to be nil for valid sub_project id" do
      sub_project = FactoryGirl.create(:sub_project)

      post :sub_project_filter , :sub_project => {:id => sub_project.id}

      assert_response :success
      @controller.expects(:sub_project_filter)
      assert_not_nil assigns(@json)
      assert_nil flash[:no_id_error]
    end

  end
end
