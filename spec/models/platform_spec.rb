require 'spec_helper'

describe Platform do
  context "validations" do
    it { should validate_presence_of(:name).with_message('cannot be blank, Task not saved') }
    it { should validate_presence_of(:product_id).with_message('cannot be blank, Task not saved') }
    it { should validate_uniqueness_of(:name).scoped_to(:product_id)}
  end

  describe "add_dependency" do
    before(:each) do
      @attr = { :platform_name => "tta_sub", :ci_job_name =>"build",:test_category => "Unit test" ,:test_sub_category => "UNIT TEST" , :test_report_type => "JUnit",:date => {:year=>"2012", :month=>"5", :day=>"26", :hour=>"07", :minute=>"46"},
                :browser => "firefox",:host_name=> "host_pc", :os_name=>"mac-osx",:type_of_environment => "dev",:logDirectory=> double(:original_filename => "abc.zip", :path => "~/Projects/tta/project_logs" )}
    end

    it "creates and saves test metadata" do
      product = FactoryGirl.create(:product)
      platform = FactoryGirl.create(:platform, :product_id => product.id)
      Parser.any_instance.stub(:parse_test_log_files)
      platform.test_metadatum.count.should == 0
      meta_data=platform.create_test_metadatum(@attr)
      platform.parse_and_save_log_files(meta_data, @attr)
      platform.test_metadatum.count.should == 1
      platform.test_metadatum.should include(meta_data)
    end
  end
end
