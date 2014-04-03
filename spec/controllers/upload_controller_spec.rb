require 'spec_helper'

describe UploadController do

  context "GET 'upload'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  context "Upload data" do

    before(:each) do
      create_or_load_project_if_not_present
      @file_with_errors = fixture_file_upload('/proj1.zip', 'application/zip')
      @upload_with_errors = {:project_name => @project.name, :sub_project_name => @sub_project.name, :ci_job_name => "build",
               :test_category => @meta_data.test_category, :test_sub_category => @meta_data.test_sub_category,
               :test_report_type => @meta_data.test_report_type,
               :date => {"year" => "2013", "month" => "2", "day" => "20", "hour" => "00", "minute" => "00"},
               :browser => "firefox", :host_name => "host_pc", :os_name => "mac-osx", :type_of_environment => "dev",
               :logDirectory => @file_with_errors}
    end

    it "uploads data with failure messages" do
      post :create, @upload_with_errors
      response.should redirect_to upload_show_path(:project_id => @project.id, :project_meta_id => @meta_data.id, :sub_project_id => @sub_project.id)
    end

  end

  context "Upload data" do

    before(:each) do
      create_or_load_project_if_not_present
      @file_without_errors = fixture_file_upload('/proj5.zip', 'application/zip')
      @upload_without_errors = {:project_name => @project.name, :sub_project_name => @sub_project.name, :ci_job_name => "build",
               :test_category => @meta_data.test_category, :test_sub_category => @meta_data.test_sub_category,
               :test_report_type => @meta_data.test_report_type,
               :date => {"year" => "2013", "month" => "2", "day" => "20", "hour" => "00", "minute" => "00"},
               :browser => "firefox", :host_name => "host_pc", :os_name => "mac-osx", :type_of_environment => "dev",
               :logDirectory => @file_without_errors}
    end

    it "uploads data and redirect to success page" do
      post :create, @upload_without_errors
      response.should redirect_to upload_show_path(:project_id => @project.id, :project_meta_id => @meta_data.id, :sub_project_id => @sub_project.id)
    end

    it "check success page shows the project details" do
      post :create, @upload_without_errors
      get :show, {:project_id => @project.id, :project_meta_id => @meta_data.id, :sub_project_id => @sub_project.id}
      response.should render_template :show
      response.code.should eq("200")
      assigns[:project].should == @project
      assigns[:sub_project].should == @sub_project
      assigns[:project_meta].should == @meta_data
      flash[:notice].should == "Project Successfully Saved!!"
    end

  end

  context "Upload data" do
    it "should return relevant list of test sub category for selected test category" do
      if (TestCategoryMapping.select("test_category") == [])
        FactoryGirl.create(:test_category_mapping)
      end
      get :get_test_sub_category, {test_category: "UNIT TEST"}
      response.body.should == "[{\"test_sub_category\":\"UNIT TEST\"}]"
    end
  end
end

def create_or_load_project_if_not_present
  @project ||= FactoryGirl.create(:project)
  @sub_project ||= FactoryGirl.create(:sub_project, :project_id => @project.id)
  @meta_data ||= FactoryGirl.create(:test_metadatum, :sub_project_id => @sub_project.id)
end