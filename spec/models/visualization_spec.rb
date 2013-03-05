require "rspec"

describe Visualization do
  TESTTYPE = YAML.load(File.open("#{Rails.root}/config/test_types.yml","r"))

  it "should return json if sub_project_id passed" do
    sub_project = FactoryGirl.create(:sub_project)
    json=Visualization.getResultJson(sub_project.id);
    json.should_not be_nil
  end

  it "should throw error when sub_project_id is nil" do
    expect{Visualization.getResultJson(nil)}.to raise_error
  end

  it "should return json with proper data" do
    project = FactoryGirl.create(:project, :name => "ProjectDummy", :authorization_level => "NULL")
    sub_project = FactoryGirl.create(:sub_project, :project_id => project.id,:name => "SubProject1.1")
    test_metadata = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:ci_job_name => "build", :os_name=> "fedora" , :host_name => "pooja-pc" , :browser => "firefox" , :type_of_environment =>"Dev" ,:date_of_execution => "2012-12-12",:test_category=>"UNIT TEST" ,:test_report_type => "JUnit")
    test_suite_record = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata.id, :class_name => "Class1.1",:number_of_tests => 30 , :number_of_errors=>2 ,:number_of_failures =>2,:time_taken=>5)
    test_case_record = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record.id,:time_taken=>1,:class_name=>"class1.1.1",:error_msg=>"")
    json= Visualization.getResultJson(sub_project.id)
    json.should eq("{\"sub_project_name\":\"SubProject1.1\",\"test_types\":[{\"test_name\":\"UNIT TEST\",\"seq_no\":101,\"percent\":\"100.00\",\"duration\":\"5.000\",\"no_of_test\":30,\"percentage_passing\":\"93.33\"}],\"unknown_test_types\":null}")
  end

  it "should return json with test_types sorted by sequence number" do
    project = FactoryGirl.create(:project, :name => "ProjectDummy", :authorization_level => "NULL")
    sub_project = FactoryGirl.create(:sub_project, :project_id => project.id,:name => "SubProject1.1")
    test_metadata = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:ci_job_name => "build", :os_name=> "fedora" , :host_name => "pooja-pc" , :browser => "firefox" , :type_of_environment =>"Dev" ,:date_of_execution => "2012-12-12",:test_category=>"UNIT TEST" ,:test_report_type => "JUnit")
    test_metadata_functional = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:ci_job_name => "build", :os_name=> "fedora" , :host_name => "pooja-pc" , :browser => "firefox" , :type_of_environment =>"Dev" ,:date_of_execution => "2012-12-12",:test_category=>"FUNCTIONAL TEST" ,:test_report_type => "JUnit")
    test_suite_record = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata.id, :class_name => "Class1.1",:number_of_tests => 800 , :number_of_errors=>2 ,:number_of_failures =>2,:time_taken=>5)
    test_suite_record_functional = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata_functional.id, :class_name => "Class1.1",:number_of_tests => 100 , :number_of_errors=>2 ,:number_of_failures =>2,:time_taken=>5)
    test_case_record = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record.id,:time_taken=>1,:class_name=>"class1.1.1",:error_msg=>"")
    test_case_record_functional = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record_functional.id,:time_taken=>1,:class_name=>"class1.1.1",:error_msg=>"")
    json= Visualization.getResultJson(sub_project.id)
    parsed_json = ActiveSupport::JSON.decode(json)
    parsed_json["test_types"][0]["seq_no"].should be > parsed_json["test_types"][1]["seq_no"]
  end

  it "should return json with proper sub_project_name" do
    project = FactoryGirl.create(:project, :name => "ProjectDummy", :authorization_level => "NULL")
    sub_project = FactoryGirl.create(:sub_project, :project_id => project.id,:name => "SubProject1.1")
    test_metadata = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:ci_job_name => "build", :os_name=> "fedora" , :host_name => "pooja-pc" , :browser => "firefox" , :type_of_environment =>"Dev" ,:date_of_execution => "2012-12-12",:test_category=>"UNIT TEST" ,:test_report_type => "JUnit")
    test_suite_record = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata.id, :class_name => "Class1.1",:number_of_tests => 30 , :number_of_errors=>2 ,:number_of_failures =>2,:time_taken=>5)
    test_case_record = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record.id,:time_taken=>1,:class_name=>"class1.1.1",:error_msg=>"")
    json= Visualization.getResultJson(sub_project.id)
    parsed_json = ActiveSupport::JSON.decode(json)
    parsed_json["sub_project_name"].should eq("SubProject1.1")
  end

  it "should  with test data having two test types ,return json with 50% unit test" do
    project = FactoryGirl.create(:project, :name => "ProjectDummy", :authorization_level => "NULL")
    sub_project = FactoryGirl.create(:sub_project, :project_id => project.id,:name => "SubProject1.1")
    test_metadata = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:ci_job_name => "build", :os_name=> "fedora" , :host_name => "pooja-pc" , :browser => "firefox" , :type_of_environment =>"Dev" ,:date_of_execution => "2012-12-12",:test_category=>"UNIT TEST" ,:test_report_type => "JUnit")
    test_metadata_functional = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:ci_job_name => "build", :os_name=> "fedora" , :host_name => "pooja-pc" , :browser => "firefox" , :type_of_environment =>"Dev" ,:date_of_execution => "2012-12-12",:test_category=>"FUNCTIONAL TEST" ,:test_report_type => "JUnit")
    test_suite_record = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata.id, :class_name => "Class1.1",:number_of_tests => 30 , :number_of_errors=>2 ,:number_of_failures =>2,:time_taken=>5)
    test_suite_record_functional = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata_functional.id, :class_name => "Class1.1",:number_of_tests => 30 , :number_of_errors=>2 ,:number_of_failures =>2,:time_taken=>5)
    test_case_record = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record.id,:time_taken=>1,:class_name=>"class1.1.1",:error_msg=>"")
    test_case_record_functional = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record_functional.id,:time_taken=>1,:class_name=>"class1.1.1",:error_msg=>"")
    json= Visualization.getResultJson(sub_project.id)
    parsed_json = ActiveSupport::JSON.decode(json)
    parsed_json["test_types"][0]["percent"].should eq("50.00")
    parsed_json["test_types"][0]["no_of_test"].should eq(30)
  end

  it "should return json with proper duration" do
    project = FactoryGirl.create(:project, :name => "ProjectDummy", :authorization_level => "NULL")
    sub_project = FactoryGirl.create(:sub_project, :project_id => project.id,:name => "SubProject1.1")
    test_metadata = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:ci_job_name => "build", :os_name=> "fedora" , :host_name => "pooja-pc" , :browser => "firefox" , :type_of_environment =>"Dev" ,:date_of_execution => "2012-12-12",:test_category=>"UNIT TEST" ,:test_report_type => "JUnit")
    test_suite_record = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata.id, :class_name => "Class1.1",:number_of_tests => 30 , :number_of_errors=>2 ,:number_of_failures =>2,:time_taken=>5)
    test_case_record = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record.id,:time_taken=>1,:class_name=>"class1.1.1",:error_msg=>"")
    json= Visualization.getResultJson(sub_project.id)
    parsed_json = ActiveSupport::JSON.decode(json)
    parsed_json["test_types"][0]["duration"].should eq("5.000")
  end

  it "should add unknown test type to the json" do
    project = FactoryGirl.create(:project)
    sub_project = FactoryGirl.create(:sub_project,:project_id => project.id)
    test_metadata = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id, :test_category => "UNKNOWN")
    test_suite_records = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata.id)
    test_case_record = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_records.id)
    json= Visualization.getResultJson(sub_project.id)
    parsed_json = ActiveSupport::JSON.decode(json)
    parsed_json["unknown_test_types"][0].should eq("UNKNOWN")

  end

end