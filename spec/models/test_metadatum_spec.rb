require 'spec_helper'

describe TestMetadatum do
  describe "create" do

    it "validate s presence of browser name" do
      should validate_presence_of(:browser).with_message("cannot be blank, Task not saved")
    end

    it "validates presence of type of environment" do
      should validate_presence_of(:type_of_environment).with_message("cannot be blank, Task not saved")
    end

    it "validates presence of host_name" do
      should validate_presence_of(:host_name).with_message("cannot be blank, Task not saved")
    end

    it "validates presence of os_name" do
      should validate_presence_of(:os_name).with_message("cannot be blank, Task not saved")
    end

    it "validates presence of date_of_execution" do
      should validate_presence_of(:date_of_execution).with_message("cannot be blank, Task not saved")
    end

    it "validates presence of test_category" do
      should validate_presence_of(:test_category).with_message("cannot be blank, Task not saved")
    end

    it "validates presence of test_report_type" do
      should validate_presence_of(:test_report_type).with_message("cannot be blank, Task not saved")
    end
  end

  describe "get_distinct_test_category" do
    it "should return records of metadata with unique test types given valid sub_proj id" do
      meta_unit = FactoryGirl.create(:test_metadatum)
      meta_functional = FactoryGirl.create(:test_metadatum, :test_category => "Functional Test")
      meta_integration = FactoryGirl.create(:test_metadatum, :test_category => "Integration Test")
      result = TestMetadatum.get_distinct_test_category(meta_unit.sub_project_id)
      #binding.pry
      result.count.should == 3
    end

    #TODO
    #it "should throw an exception if no sub_proj_id given" do
    #  expect {TestMetadatum.get_distinct_test_category(nil)}.to raise_error
    #
    #end
  end
end
