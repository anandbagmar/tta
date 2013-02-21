require "rspec"

describe ComparativeAnalysis do

  it "should return result set" do
    result = ComparativeAnalysis.get_result_set(1,"1990-1-1","2012-12-12")
    result.should_not be_nil
  end

  it "should throw error if sub_project id not given" do
    expect{ComparativeAnalysis.get_result_set(nil,nil,nil)}.to raise_error
  end

  it "should return result set with a single point if project has only one build between the date range" do
    project = FactoryGirl.create(:project)
    sub_project = FactoryGirl.create(:sub_project, :project_id => project.id)
    test_metadata = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id)
    test_suite_record = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata.id)
    test_case_record = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record.id)

    result = ComparativeAnalysis.get_result_set(project.id,"2013-01-01","2013-03-30")
    result["TTA_subProject"].count.should eq(1)
  end

  it "should return the result set with points in increasing order of the date of execution" do
    project = FactoryGirl.create(:project)
    sub_project = FactoryGirl.create(:sub_project, :project_id => project.id)
    test_metadata_1 = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id)
    test_metadata_2 = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:date_of_execution => "2013-01-16")
    test_metadata_3 = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:date_of_execution => "2013-01-10")

    test_suite_record_1 = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata_1.id)
    test_suite_record_2 = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata_2.id)
    test_suite_record_3 = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata_3.id)

    test_case_record = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record_1.id)
    test_case_record = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record_2.id)
    test_case_record = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record_3.id)

    test_metadata_list = [test_metadata_1,test_metadata_2,test_metadata_3]
    final_result=test_metadata_list.inject([]){ |result1, metadata_record|
      total_num_of_tests = 0
      number_of_failures = 0
      metadata_record.test_suite_records.each do |test_suite_record|
        total_num_of_tests += test_suite_record.number_of_tests.to_i
        number_of_failures += test_suite_record.number_of_failures.to_i
      end
      result1 << [(metadata_record.date_of_execution.to_time.to_f * 1000), (total_num_of_tests.to_f - number_of_failures.to_f) / total_num_of_tests.to_f  * 100]
    }
    result = ComparativeAnalysis.get_result_set(project.id,"2013-01-01","2013-03-30")
    final_result.reverse.should eq(result[sub_project.name])
  end

  it "should return result set with different points if tests with different pass % present for same day" do
    project = FactoryGirl.create(:project)
    sub_project = FactoryGirl.create(:sub_project, :project_id => project.id)
    test_metadata = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id)
    test_metadata_1 = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:test_category => "Functional Test")
    test_suite_record = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata.id,:number_of_tests=>"20",:number_of_errors=>"10")
    test_suite_record_1 = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata_1.id)
    test_case_record = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record.id)
    test_case_record_1 = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record_1.id)

    result = ComparativeAnalysis.get_result_set(project.id,"2013-01-01","2013-03-30")
    result[sub_project.name].count.should eq(2)
  end

  it "should return proper result set for valid data" do
    project = FactoryGirl.create(:project)
    sub_project = FactoryGirl.create(:sub_project, :project_id => project.id)
    test_metadata = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id)
    test_metadata_1 = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:date_of_execution=>"2013-01-01")
    test_metadata_2 = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:date_of_execution=>"2013-01-09")
    test_suite_record = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata.id)
    test_suite_record_1 = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata_1.id)
    test_suite_record_2 = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata_2.id)
    test_case_record = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record.id)
    test_case_record_1 = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record_1.id)
    test_case_record_2 = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record_2.id)

    result = ComparativeAnalysis.get_result_set(project.id,"2013-01-01","2013-03-30")
    result[sub_project.name].count.should eq(3)
  end

end