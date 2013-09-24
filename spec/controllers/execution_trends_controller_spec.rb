require 'spec_helper'

describe ExecutionTrendsController do

  context 'new' do
    it "should render new execution trend page" do
      project1 = FactoryGirl.create(:project, name: 'tta project 1')
      project2 = FactoryGirl.create(:project, name: 'tta project 2')
      get 'new'
      response.should be_success
      controller.instance_variable_get(:@projects).should == "[{\"id\":#{project1.id},\"name\":\"#{project1.name}\"},{\"id\":#{project2.id},\"name\":\"#{project2.name}\"}]"
      Project.count.should == 2
    end
  end

  context 'class_names' do
    it 'should return class_names for selected filters if request is xhr' do
      project= FactoryGirl.create(:project)
      sub_project= FactoryGirl.create(:sub_project, project: project)
      metadata= FactoryGirl.create(:test_metadatum, sub_project_id: sub_project.id, date_of_execution: Date.today)
      suite_record= FactoryGirl.create(:test_suite_records, test_metadatum: metadata)
      case_record= FactoryGirl.create(:test_case_record, test_suite_record: suite_record)
      xhr :get, :class_names, {subproject_id: sub_project.id, test_category: metadata.test_category, start_date: Date.yesterday.to_s, end_date: Date.today.to_s}
      response.should be_success
      response.body.should == "[{\"class_name\":\"#{case_record.class_name}\"}]"
    end

    it 'should render bad request if request is not xhr' do
      (get :class_names).should be_bad_request
    end
  end
end
