require "rspec"

describe "ComparativeAnalysiscontroller" do
  describe "routing" do
    it " routes to get test category mapping list action" do
      { get: '/test_category_mapping_list' }.should route_to('comparative_analysis#test_category_mapping_list')
    end
  end
end