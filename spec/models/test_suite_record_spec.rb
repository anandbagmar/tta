require 'spec_helper'

describe TestSuiteRecord do
  describe "belongs to" do
    it "test_metadata" do
      should belong_to :test_metadatum
    end
  end

  describe "initilize_to_zero_if_nil" do
    before do
      @test_suite_record = TestSuiteRecord.new({})
    end
    it "should return zero if value is nil" do
      @test_suite_record.initilize_to_zero_if_nil(nil).should eq(0)
    end
    it "should return value if given value is not nil" do
      @test_suite_record.initilize_to_zero_if_nil(10).should eq(10)
    end
  end
end
