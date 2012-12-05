require 'spec_helper'

describe ProjectMetadatum do
  describe "create" do
    it "validates presence of sub_project_name" do
      should validate_presence_of(:sub_project_name).with_message("cannot be blank, Task not saved")
    end

    it "validate s presence of browser name" do
      should validate_presence_of(:browser).with_message("cannot be blank, Task not saved")
    end

    it "validates presence of type of enviornment" do
      should validate_presence_of(:type_of_enviornment).with_message("cannot be blank, Task not saved")
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
  end
end
