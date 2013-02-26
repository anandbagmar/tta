require 'spec_helper'
require 'rspec'

describe Admin do

  it "should return message if no projects in database" do
    json= Admin.get_result_json
    parse_json = ActiveSupport::JSON.decode(json)
    parse_json.has_key?("message")
  end

  date_of_execution = "2013-02-02"
  it "should not return nil json when admin_url is hit" do
    date_of_execution = "2013-02-02"
    project1 = FactoryGirl.create(:project,:name => "TTA1")
    sub_project11 = FactoryGirl.create(:sub_project, :project_id => project1.id,:name => "TTA_subProject1")
    test_metadata_1 = FactoryGirl.create(:test_metadatum, :sub_project_id => sub_project11.id, :date_of_execution => date_of_execution)
    project2 = FactoryGirl.create(:project , :name => "TTA2")
    sub_project21 = FactoryGirl.create(:sub_project, :project_id => project2.id,:name => "TTA_subProject2")
    test_metadata_2 = FactoryGirl.create(:test_metadatum, :sub_project_id => sub_project21.id, :date_of_execution => date_of_execution)
    project=Array.new
    project.push(project1)
    project.push(project2)
    binding.pry
    json = Admin.get_result_json(project)
    json.should_not be_nil
  end

  it "should return correct count in json" do
  date_of_execution = "2013-02-02"
  project1 = FactoryGirl.create(:project, :name => "TTA11")
  sub_project11 = FactoryGirl.create(:sub_project, :project_id => project1.id,:name => "TTA_subProject11")
  test_metadata_11 = FactoryGirl.create(:test_metadatum, :sub_project_id => sub_project11.id, :date_of_execution => date_of_execution)
  sub_project12 = FactoryGirl.create(:sub_project, :project_id => project1.id,:name => "TTA_subProject12")
  test_metadata_12 = FactoryGirl.create(:test_metadatum, :sub_project_id => sub_project12.id, :date_of_execution => date_of_execution)
  test_metadata_13 = FactoryGirl.create(:test_metadatum, :sub_project_id => sub_project12.id, :date_of_execution => date_of_execution)
  test_metadata_14 = FactoryGirl.create(:test_metadatum, :sub_project_id => sub_project12.id, :date_of_execution => date_of_execution)

  project2 = FactoryGirl.create(:project , :name => "TTA12")
  sub_project21 = FactoryGirl.create(:sub_project, :project_id => project2.id,:name => "TTA_subProject21")
  test_metadata_21 = FactoryGirl.create(:test_metadatum, :sub_project_id => sub_project21.id, :date_of_execution => date_of_execution)
  test_metadata_22 = FactoryGirl.create(:test_metadatum, :sub_project_id => sub_project21.id, :date_of_execution => date_of_execution)
  sub_project22 = FactoryGirl.create(:sub_project, :project_id => project2.id,:name => "TTA_subProject22")
  test_metadata_23 = FactoryGirl.create(:test_metadatum, :sub_project_id => sub_project22.id, :date_of_execution => date_of_execution)
  test_metadata_24 = FactoryGirl.create(:test_metadatum, :sub_project_id => sub_project22.id, :date_of_execution => "2013-02-02")

  expect_json= {"#{project1.id}" =>[{"project_name" => "#{project1.name}"},
                                {"sub_projects" => ["#{sub_project11.name}","#{sub_project12.name}"]},
                                {"test_count"   => [1,3]}],
                "#{project2.id}" =>[{"project_name" => "#{project2.name}"},
                               {"sub_projects" => ["#{sub_project21.name}","#{sub_project22.name}"]},
                               {"test_count"   => [2,2]}]
               }

  project=Array.new
  project.push(project1)
  project.push(project2)
  actual_json = Admin.get_result_json(project)
  parse_json = ActiveSupport::JSON.decode(actual_json)

  parse_json.should eq(expect_json)
  end
end


