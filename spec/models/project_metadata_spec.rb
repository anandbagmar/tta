require 'spec_helper'

describe ProjectMetaDatum do
  describe "create" do
    it "creates project meta data" do
      project_meta_data = ProjectMetaDatum.create!(
                                       :browser => "Firefox" ,
                                       :host_name=> "avinash-PC" ,
                                       :os_name => "Ubuntu" ,
                                       :user_timezone => "UTC"
                                       )
      expect(ProjectMetaDatum.last).to eq(project_meta_data)
    end
  end
end
