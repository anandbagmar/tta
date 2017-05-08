require 'spec_helper'

describe ExecutionTrendsController, type: :controller do
  context 'class_names' do
    it 'should return class_names for selected filters if request is xhr' do
      product = FactoryGirl.create(:product)
      platform = FactoryGirl.create(:platform, product: product)
      metadata= FactoryGirl.create(:test_metadatum, platform_id: platform.id, date_of_execution: Date.today, branch: "master")
      suite_record= FactoryGirl.create(:test_suite_records, test_metadatum: metadata)
      case_record= FactoryGirl.create(:test_case_record, test_suite_record: suite_record)
      xhr :get, :class_names, {platform_id: platform.id, test_category: metadata.test_category, start_date: Date.yesterday.to_s, end_date: Date.today.to_s}
      response.should be_success
      JSON.parse(response.body).should == [{'id' => nil, 'class_name' => case_record.class_name}]
    end

    it 'should render bad request if request is not xhr' do
      (get :class_names).should be_bad_request
    end
  end

  context 'show' do
    it 'should return result data set for selected filters' do
      time_taken = [[1234567890.000, 0.01234]]
      ExecutionTrends.any_instance.should_receive(:get_time_taken).and_return([time_taken, 1.01234])
      Platform.should_receive(:get_platform_name).and_return("TTA Product")
      class_name = 'UNIT TEST'
      post :show, {
          platforms: 1,
          test_class_name: class_name,
          start_date: Date.yesterday.to_s,
          end_date: Date.today.to_s
      }
      controller.instance_variable_get(:@result_set).should == {"TTA Product" => {"UNIT TEST" => time_taken}}
      controller.instance_variable_get(:@start_date).should == Date.yesterday.to_s
      controller.instance_variable_get(:@end_date).should == Date.today.to_s
      controller.instance_variable_get(:@max_value).should == 1.01234
    end

    it 'should return empty data set for empty filters' do
      ExecutionTrends.any_instance.should_not_receive(:get_time_taken).and_return()
      Platform.should_receive(:get_platform_name)
      post :show, {
          test_class_name: ""
      }
      controller.instance_variable_get(:@result_set).should == {nil => {}}
    end

    it 'should return empty data set for empty filters' do
      ExecutionTrends.any_instance.should_not_receive(:get_time_taken)
      Platform.should_receive(:get_platform_name)
      post :show, {
          test_class_name: nil
      }
      controller.instance_variable_get(:@result_set).should == {nil => {}}
    end
  end
end
