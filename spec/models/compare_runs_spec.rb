require "rspec"

include DataHelper

module CompareRunsDataHelper
    
    def create_tests_data_and_return_metadata_for_date(date_of_execution , class_name)
        test_metadata = create_metadatum(sub_project,date_of_execution,unit_tests)
        test_suite_record =  create_suite_with_metadata(test_metadata , class_name)
        add_failed_tests_from_suite(test_suite_record) 
        test_metadata
    end

    def get_class_name_suite_id_hash(test_metadata1,test_metadata2)
        TestSuiteRecord
        .get_class_name_suite_id_hash(test_metadata1.id,test_metadata2.id)
    end
end


describe CompareRuns do    
   
    let(:project) {create(:project)}
    let(:sub_project){sub_project = create_subproject_for_project project}
    let(:unit_tests){"UNIT TESTS"}
    let(:jan_1_2013){"2013-01-01 00:00:00 UTC"}
    let(:jan_2_2013){"2013-01-02 00:00:00 UTC"}

    include CompareRunsDataHelper    

    it "should return metadata record_for_specific_date" do         
        inserted_metadata = create_metadatum(sub_project,jan_1_2013,unit_tests)
        retrieved_metadata = get_metadata(sub_project , unit_tests , jan_1_2013)
        retrieved_metadata.first.id.should eql inserted_metadata.id
        retrieved_metadata.first.date_of_execution.should eq(jan_1_2013)        
    end

    it "should return classname suite" do        
        arr_classnames = ["class_name_suite_1","class_name_suite_2"] 
        
        get_class_name_suite_id_hash(
            create_tests_data_and_return_metadata_for_date(jan_1_2013 , arr_classnames[0]) ,
            create_tests_data_and_return_metadata_for_date(jan_2_2013 , arr_classnames[1])
        ).keys.should include(*arr_classnames)                 
         
    end


    # it "should return classnames suite" do

    #     test_metadata1 = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:date_of_execution => "2013-03-03",:test_category => unit_tests)
    #     test_metadata2 = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:date_of_execution => "2013-03-05",:test_category => unit_tests)

    #     inserted_metadata1 = create_metadatum(sub_project,jan_1_2013,unit_tests)
    #     inserted_metadata2 = create_metadatum(sub_project,jan_2_2013,unit_tests)

    #     test_suite_record1 = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata1.id,:class_name => "visualization_controller")
    #     test_suite_record2 = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata2.id,:class_name => "visualization_controller")

    #     test_case_record1=FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record1.id)
    #     test_case_record2=FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record2.id)

    #     metadata=[]
    #     metadata << TestMetadatum.get_record_for_specific_date(sub_project.id,test_metadata1.test_category,test_metadata1.date_of_execution )
    #     metadata << TestMetadatum.get_record_for_specific_date(sub_project.id,test_metadata2.test_category,test_metadata2.date_of_execution )
    #     result_hash=TestSuiteRecord.get_class_name_suite_id_hash(metadata[0][0].id, metadata[1][0].id)

    #     result_hash.each do|classname|
    #         classname[0].should eq( test_suite_record1.class_name) or classname[0].should eq( test_suite_record2.class_name)
    #     end
    # end


    it "should return both test cases failing" do     

        test_metadata1 = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:date_of_execution => "2013-03-03",:test_category => unit_tests)
        test_metadata2 = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:date_of_execution => "2013-03-05",:test_category => unit_tests)

        test_suite_record1 = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata1.id,:class_name => "visualization_controller")
        test_suite_record2 = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata2.id,:class_name => "visualization_controller")

        test_case_record1=FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record1.id,:error_msg =>"legends improper",:class_name => "visualization_controller")
        test_case_record2=FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record2.id,:error_msg =>"legends improper",:class_name => "visualization_controller")

        metadata=[]
        metadata << TestMetadatum.get_record_for_specific_date(sub_project.id,test_metadata1.test_category,test_metadata1.date_of_execution )
        metadata << TestMetadatum.get_record_for_specific_date(sub_project.id,test_metadata2.test_category,test_metadata2.date_of_execution )

        result_hash=TestSuiteRecord.get_class_name_suite_id_hash(metadata[0][0].id, metadata[1][0].id)
        @test_case_id=[]
        test_case_id1=[]
        test_case_id2=[]

        result_hash.values.each do |suite_id_arrs|
            suite_id_arrs[0].zip(suite_id_arrs[1]).each do |id1, id2|
                test_case_id1 << TestCaseRecord.select("id,error_msg").where("test_suite_record_id="+id1.to_s+" AND error_msg!='' ")
                test_case_id2 << TestCaseRecord.select("id,error_msg").where("test_suite_record_id="+id2.to_s+" AND error_msg!='' ")
            end
        end
        a = test_case_id1[0][0].error_msg.nil?
        b=  test_case_id2[0][0].error_msg.nil?
        a.should be_false and  b.should be_false
    end

  it "should return no same test cases failing" do
     
    test_metadata1 = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:date_of_execution => "2013-03-03",:test_category => unit_tests)
    test_metadata2 = FactoryGirl.create(:test_metadatum,:sub_project_id => sub_project.id,:date_of_execution => "2013-03-05",:test_category => unit_tests)

    test_suite_record1 = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata1.id,:class_name => "visualization_controller")
    test_suite_record2 = FactoryGirl.create(:test_suite_records,:test_metadatum_id => test_metadata2.id,:class_name => "visualization_controller")

    test_case_record1=FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record1.id,:error_msg =>"legends improper",:class_name => "visualization_controller")
    test_case_record2=FactoryGirl.create(:test_case_record,:test_suite_record_id => test_suite_record2.id,:error_msg =>"wrong data",:class_name => "visualization_controller")

    metadata=[]
    metadata << TestMetadatum.get_record_for_specific_date(sub_project.id,test_metadata1.test_category,test_metadata1.date_of_execution )
    metadata << TestMetadatum.get_record_for_specific_date(sub_project.id,test_metadata2.test_category,test_metadata2.date_of_execution )

    result_hash=TestSuiteRecord.get_class_name_suite_id_hash(metadata[0][0].id, metadata[1][0].id)
    @test_case_id=[]
    test_case_id1=[]
    test_case_id2=[]

    result_hash.values.each do |suite_id_arrs|
      suite_id_arrs[0].zip(suite_id_arrs[1]).each do |id1, id2|
        test_case_id1 << TestCaseRecord.select("id,error_msg").where("test_suite_record_id="+id1.to_s+" AND error_msg!='' ")
        test_case_id2 << TestCaseRecord.select("id,error_msg").where("test_suite_record_id="+id2.to_s+" AND error_msg!='' ")
      end
    end
    a = test_case_id1[0][0].error_msg
    b=  test_case_id2[0][0].error_msg
    a.should_not eq(b)
  end
end
