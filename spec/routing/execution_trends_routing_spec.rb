require "rspec"

describe "ExecutionTrends" do
  describe "routing" do
    it " routes to new action" do
      {get: '/execution_trends'}.should route_to('execution_trends#new')
    end
  end
end