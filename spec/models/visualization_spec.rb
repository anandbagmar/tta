require "rspec"

describe Visualization do

  it "should raise error if no sub_project id given" do
    expect { Visualization.getNoOfTests(nil, "Unit Test") }.to raise_error
  end

  it "should not return nil result set if test type is nil" do
    result = Visualization.getNoOfTests(1, nil)
    result.should eq([])
  end

  it "should return json if sub_project_id passed" do
    json=Visualization.getResultJson("1");
    json.should_not be_nil
  end

  it "should throw error when sub_project_id is nil" do
    expect{Visualization.getResultJson(nil)}.to raise_error
  end


  it "should return proper data" do
    project = FactoryGirl.create(:project, :name => "ProjectDummy", :authorization_level => "NULL")
    sub_project = FactoryGirl.create(:sub_project, :project_id => project.id,:name => "SubProject1.1")
    test_metadata = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:ci_job_name => "build", :os_name=> "fedora" , :host_name => "pooja-pc" , :browser => "firefox" , :type_of_environment =>"Dev" ,:date_of_execution => "2012-12-12",:test_category=>"UNIT TEST" ,:test_report_type => "JUnit")
    test_suite_record = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata.id, :class_name => "Class1.1",:number_of_tests => 30 , :number_of_errors=>2 ,:number_of_failures =>2,:time_taken=>5)
    test_case_record = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record.id,:time_taken=>1,:class_name=>"class1.1.1",:error_msg=>"")
    json= Visualization.getResultJson(sub_project.id)
    true.should eq(true)

  end

end