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
      @file = fixture_file_upload('/proj5.zip', 'application/zip')
      @attr = {:project_name => "tta", :sub_project_name => "tta_sub", :ci_job_name => "build", :test_category => "Unit test", :test_report_type => "JUnit", :date => {"year"=>"2012", "month"=>"5", "day"=>"26", "hour"=>"07", "minute"=>"46"},
               :browser => "firefox", :host_name => "host_pc", :os_name => "mac-osx", :type_of_environment => "dev", :logDirectory => @file}

    end
    it "uploads data and redirect to success page" do

      post :create, @attr
      create_or_load_project_if_not_present()

      response.should redirect_to upload_show_path(:project_id => @project.id, :project_meta_id => @meta_data.id, :sub_project_id => @sub_project.id)

    end

    it "check success page shows the project details" do
      post :create, @attr
      create_or_load_project_if_not_present()
      get :show, {:project_id => @project.id, :project_meta_id => @meta_data.id, :sub_project_id => @sub_project.id}

      response.should render_template :show
      response.code.should eq("200")
      assigns[:project].should == @project
      assigns[:sub_project].should == @sub_project
      assigns[:project_meta].should == @meta_data
      flash[:notice].should == "Project Successfully Saved!!"

    end

    def create_or_load_project_if_not_present
      @project = Project.find_or_create_by_name("tta")
      @sub_project = @project.sub_projects.find_or_create_by_name("tta_sub")
      @meta_data = TestMetadatum.find_or_create_by_sub_project_id(@sub_project.id)
    end



  end

end


