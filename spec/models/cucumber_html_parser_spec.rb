describe CucumberHtmlParser do
  describe 'Visualization,ComparativeAnalysis,DefectAnalysis' do

    it "should return proper json on valid data entry for Cucumber HTML Parser" do
      product = FactoryGirl.create(:product)
      platform = FactoryGirl.create(:platform, :product_id => product.id)
      test_metadata = FactoryGirl.create(:test_metadatum,:platform_id => platform.id,:test_report_type =>"Cucumber HTML", :branch => "master")
      test_suite_record = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata.id)
      FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record.id)
      FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record.id)
      FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record.id)
      FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record.id)

      result_visualization = Visualization.new.getResultJson(platform.id)
      result_visualization.should eq("{\"platform_name\":\"TTA_PLATFORM\",\"test_types\":[{\"test_name\":\"UNIT TEST\",\"seq_no\":101,\"percent\":\"100.00\",\"duration\":\"00:00:02:000\",\"no_of_test\":10,\"percentage_passing\":\"60.00\"}],\"unknown_test_types\":null}")

      result_comparative = ComparativeAnalysis.new.get_result_set(product.id,platform.id,nil,"2013-01-01".to_date,"2013-03-30".to_date)
      result_comparative.should eq({"TTA_PLATFORM"=>{"UNIT TEST : UNIT TEST"=>[[1361318400000.0, 60.0]]}})

      result_defect = DefectAnalysis.new.get_result_json(platform.id,"2013-02-20".to_date,"UNIT TEST")
      result_defect.should eq("{\"platform_name\":\"TTA_PLATFORM\",\"errors\":{\"UNIT TEST\":[{\"ERROR_MSG\":[\"Class_01\",\"Class_01\",\"Class_01\",\"Class_01\"]}]},\"percentage\":[\"100.00\"]}")
    end
  end
end