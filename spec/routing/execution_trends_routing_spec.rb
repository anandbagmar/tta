require "rspec"

describe "ExecutionTrends", :type => :routing do
  context "routes" do
    it "should route to new action" do
      {get: '/execution_trends'}.should route_to('execution_trends#new')
    end

    it "should route to class_names action" do
      {get: '/get_class_names'}.should route_to('execution_trends#class_names')
    end

    it "should route to show action" do
      {post: '/execution_trends/result'}.should route_to('execution_trends#show')
    end

  end
end