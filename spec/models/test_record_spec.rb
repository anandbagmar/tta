require 'spec_helper'

describe TestRecord do
  describe "create" do
    it "creates Test Records" do
      test_record = TestRecord.create!(:class_name => "services.gateways.BenefitsServiceGatewayTest" ,
                                       :number_of_tests=> 12 ,
                                       :number_of_failures => 10 ,
                                       :number_of_errors => 5 ,
                                       :time_taken => "10")
      expect(TestRecord.last).to eq(test_record)
    end
  end
end
