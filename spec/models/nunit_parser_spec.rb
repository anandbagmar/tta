class NunitParserSpec

  describe Visualization,ComparativeAnalysis,DefectAnalysis do

    it "should return proper json on valid data entry for NUnit Parser" do
      project = FactoryGirl.create(:project)
      sub_project = FactoryGirl.create(:sub_project, :project_id => project.id)
      test_metadata = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:test_report_type =>"Unit NUnit")
      test_suite_record = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata.id,:number_of_tests_not_run=> 1,:number_of_tests_ignored=> 2)
      test_case_record_1 = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record.id)
      test_case_record_2 = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record.id)
      test_case_record_3 = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record.id)
      test_case_record_4 = FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record.id)

      result_visualization = Visualization.getResultJson(sub_project.id)
      result_visualization.should eq("{\"sub_project_name\":\"TTA_subProject\",\"test_types\":[{\"test_name\":\"UNIT TEST\",\"seq_no\":101,\"percent\":\"100.00\",\"duration\":\"2.000\",\"test_no\":10,\"percentage_passing\":\"60.00\"}],\"unknown_test_types\":null}")

      result_comparative = ComparativeAnalysis.get_result_set(project.id,"2013-01-01","2013-03-30")
      result_comparative.should eq({"TTA_subProject"=>[[1361318400000.0, 50.0]]})

      result_defect = DefectAnalysis.get_result_json(sub_project.id,"2013-02-20")
      result_defect.should eq("{\"sub_project_name\":\"TTA_subProject\",\"errors\":{\"UNIT TEST\":[{\"ERROR_MSG\":[\"Class_01\",\"Class_01\",\"Class_01\",\"Class_01\"]}]},\"percentage\":[\"100.00\"]}")


    end

  end

end













