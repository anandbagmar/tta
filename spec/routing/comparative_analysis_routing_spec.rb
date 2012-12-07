require "spec_helper"

describe ComparativeAnalysisController do
  describe "routing" do
  it "should route to comparative_analysis/create" do
    assert_generates '/comparative_analysis/create' ,  :controller => 'comparative_analysis', :action => 'create'
    end
  end
end