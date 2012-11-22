require 'spec_helper'

describe ProjectMetadatum do
  describe "create" do
    it "creates project meta data" do

      project = Project.create(:authorization_level => "all",
                               :name => "VSP",
                               :type_of_report => "JUnit"
      )
      project.save

      project_metadata = ProjectMetadatum.create(
                                       :browser => "Firefox" ,
                                       :host_name=> "avinash-PC" ,
                                       :os_name => "Ubuntu" ,
                                       :user_timezone => "UTC"
                                       )
      project_metadata.project = project

      project_metadata.save

      expect(ProjectMetadatum.last).to eq(project_metadata)
    end
  end
end
