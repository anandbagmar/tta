require 'spec_helper'

describe Project do
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  context "add_sub_project" do
    before(:each) do
      @attr = {:sub_project_name => "tta_sub", :ci_job_name => "build", :test_category => "Unit test", :test_report_type => "JUnit", :date => {:year => "2012", :month => "5", :day => "26", :hour => "07", :minute => "46"},
               :browser => "firefox", :host_name => "host_pc", :os_name => "mac-osx", :type_of_environment => "dev", :logDirectory => mock(:original_filename => "abc.zip", :path => $PROJECT_ROOT+"/Err_test.zip")}
    end

    it "adds sub_project to under the project" do
      project = Fabricate(:project)
      project.sub_projects.should be_empty
      Parser.any_instance.stub(:unzip)
      sub_proj, meta_data = project.add_sub_project(@attr)
      project.sub_projects.count.should == 1
      project.sub_projects.should include(sub_proj)
    end
  end

  context "scope" do
    it "gets all the project record entries" do
      project1 = FactoryGirl.create(:project, name: 'tta1')
      project2 = FactoryGirl.create(:project, name: 'tta2')
      Project.get_all_projects.count == 2
      Project.get_all_projects.should == [project1, project2]
    end
  end
end


