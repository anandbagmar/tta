require 'spec_helper'
require 'rspec'

describe Admin do

  it "should return message if no projects in database" do
     json= Admin.get_result_json
    parse_json = ActiveSupport::JSON.decode(json)
    parse_json.has_key?("message")
  end

  it "should return json when admin_url is hit" do
    project1 = FactoryGirl.create(:project)
    sub_project11 = FactoryGirl.create(:sub_project, :project_id => project1.id)
    #sub2_project = FactoryGirl.create(:sub_project, :project_id => project1.id)
    #sub3_project = FactoryGirl.create(:sub_project, :project_id => project1.id)
    test_metadata_1 = FactoryGirl.create(:test_metadatum, :sub_project_id => sub_project11.id, :date_of_execution => "2013-02-02")
    project2 = FactoryGirl.create(:project , :name => "TTA2")
    sub_project21 = FactoryGirl.create(:sub_project, :project_id => project2.id)
    test_metadata_2 = FactoryGirl.create(:test_metadatum, :sub_project_id => sub_project21.id, :date_of_execution => "2013-02-02")
    #sub2_project = FactoryGirl.create(:sub_project, :project_id => project2.id)

    json = Admin.get_result_json
    json.should_not be_nil
  end


end
