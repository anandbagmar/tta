require "rspec"

describe ComparativeAnalysis do

  it "should return result set" do
    result = ComparativeAnalysis.get_result_set(1,"2012-1-1","2012-12-12")
    result.should_not be_nil
  end

  it"should throw error if sub_project id not given" do
 expect{ComparativeAnalysis.get_result_set(nil,nil,nil)}.to raise_error
  end

end