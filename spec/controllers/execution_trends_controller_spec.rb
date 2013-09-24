require 'spec_helper'

describe ExecutionTrendsController do

  describe 'new' do
    it "should render new execution trend page" do
      project1 = FactoryGirl.create(:project, name: 'tta project 1')
      project2 = FactoryGirl.create(:project, name: 'tta project 2')
      get 'new'
      response.should be_success
      controller.instance_variable_get(:@projects).should == "[{\"id\":#{project1.id},\"name\":\"#{project1.name}\"},{\"id\":#{project2.id},\"name\":\"#{project2.name}\"}]"
      Project.count.should == 2
    end
  end

end
