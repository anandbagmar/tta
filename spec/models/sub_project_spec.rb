require 'spec_helper'

describe SubProject do

  it "validates presence of sub_project_name" do
    should validate_presence_of(:name).with_message("cannot be blank, Task not saved")
  end

  describe "add_dependency" do
    before(:each) do
      @attr = { :sub_project_name => "tta_sub", :ci_job_name =>"build",:test_category => "Unit test" , :test_report_type => "JUnit",:date => {:year=>"2012", :month=>"5", :day=>"26", :hour=>"07", :minute=>"46"},
                :browser => "firefox",:host_name=> "host_pc", :os_name=>"mac-osx",:type_of_environment => "dev",:logDirectory=> mock(:original_filename => "abc.zip", :path => "~/Projects/tta/project_logs" )}
    end

    it "creates and saves test metadata" do
      project = FactoryGirl.create(:project)
      sub_project = FactoryGirl.create(:sub_project, :project_id => project.id)
      Parser.any_instance.stub(:parse_test_log_files)
      sub_project.test_metadatum.count.should == 0
      meta_data=sub_project.create_test_metadatum(@attr)
      sub_project.parse_and_save_log_files(meta_data, @attr)
      sub_project.test_metadatum.count.should == 1
      sub_project.test_metadatum.should include(meta_data)
    end
  end


end
