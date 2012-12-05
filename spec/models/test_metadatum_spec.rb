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

    it "validates presence of type_of_test" do
      should validate_presence_of(:type_of_test).with_message("cannot be blank, Task not saved")
    end
  end
end
