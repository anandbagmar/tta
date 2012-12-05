require 'spec_helper'

describe SubProject do

  it "validates presence of sub_project_name" do
    should validate_presence_of(:name).with_message("cannot be blank, Task not saved")
  end

end
