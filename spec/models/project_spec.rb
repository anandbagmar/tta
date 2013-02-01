require 'spec_helper'

describe Project do
  describe "create" do
    it "active record validations" do
      should validate_uniqueness_of :name
      should validate_presence_of :name
    end
  end

  describe "add_sub_project" do
    before(:each) do
      @attr = { :sub_project_name => "tta_sub", :ci_job_name =>"build",:test_category => "Unit test" , :test_report_type => "JUnit",:date => {:year=>"2012", :month=>"5", :day=>"26", :hour=>"07", :minute=>"46"},
                :browser => "firefox",:host_name=> "host_pc", :os_name=>"mac-osx",:type_of_environment => "dev",:logDirectory=> mock(:original_filename => "abc.zip", :path => "/Users/pooja/Documents/tta/logs/" )}
    end

    it "adds sub_project to under the project" do
      project = Fabricate(:project)
      project.sub_projects.should be_empty
      XmlParser.stub(:parse)
      sub_proj,meta_data = project.add_sub_project(@attr)
      project.sub_projects.count.should == 1
      project.sub_projects.should include(sub_proj)
    end
  end
end
