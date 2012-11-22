require 'spec_helper'

describe TestRecord do
  describe "create" do
    it "creates Test Records" do

      project = Project.create(:authorization_level => "all",
                                :name => "VSP",
                                :type_of_report => "JUnit"
      )
      project.save

      project_metadatum = ProjectMetadatum.create(
          :browser => "Firefox" ,
          :host_name=> "avinash-PC" ,
          :os_name => "Ubuntu" ,
          :user_timezone => "UTC"
      )

      project_metadatum.project = project
      project_metadatum.save

      test_record = TestRecord.create(:class_name => "services.gateways.BenefitsServiceGatewayTest" ,
                                       :number_of_tests=> 12 ,
                                       :number_of_failures => 10 ,
                                       :number_of_errors => 5 ,
                                       :time_taken => "10")

      test_record.project_metadatum = project_metadatum
      test_record.save

      expect(TestRecord.last).to eq(test_record)
    end
  end
end
