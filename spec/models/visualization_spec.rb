require "rspec"

describe Visualization do

  it "should raise error if no sub_project id given" do
  expect{Visualization.getNoOfTests(nil,"Unit Test")}.to raise_error
  end

  it "should not return nil result set if test type is nil" do
    result = Visualization.getNoOfTests(1,nil)
    result.should eq([])
  end
end