require 'spec_helper'

describe Project do
  describe "create" do
    it "creates projects" do
      project = Project.create!(:authorization_level => "all",
                                       :name => "VSP",
                                       :type_of_report => "JUnit"
                                       )
      expect(Project.last).to eq(project)
    end
  end
end
