require "spec_helper"

describe "Test Category mapping" do
  context "get sub test category" do
    it "should return list of sub test category for selected test category" do
      functional_test_sub_category = ["BUILD VERIFICATION TEST", "SMOKE TEST", "SANITY TEST", "REGRESSION TEST", "PERFORMANCE TEST", "ACCEPTANCE TEST"]
      sub_categories               = TestCategoryMapping.new.get_sub_category("FUNCTIONAL TEST")
      sub_categories.each do |sub_category|
        (sub_category["test_sub_category"].in? functional_test_sub_category).should == true
      end
    end
  end
end