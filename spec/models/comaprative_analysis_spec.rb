require "rspec"

describe ComparativeAnalysis do

  it "should return result set" do
    result = ComparativeAnalysis.getPercentageOfPassingTests(1,"1960-12-12","2012-12-14")
    result.should_not be_nil
  end
  #
  #it"should throw error if sub_project not found" do
  #
  #
  #end

end