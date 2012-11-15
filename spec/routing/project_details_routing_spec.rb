require "spec_helper"

describe ProjectDetailsController do
  describe "routing" do

    it "routes to #index" do
      get("/project_details").should route_to("project_details#index")
    end

    it "routes to #new" do
      get("/project_details/new").should route_to("project_details#new")
    end

    it "routes to #show" do
      get("/project_details/1").should route_to("project_details#show", :id => "1")
    end

    it "routes to #edit" do
      get("/project_details/1/edit").should route_to("project_details#edit", :id => "1")
    end

    it "routes to #create" do
      post("/project_details").should route_to("project_details#create")
    end

    it "routes to #update" do
      put("/project_details/1").should route_to("project_details#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/project_details/1").should route_to("project_details#destroy", :id => "1")
    end

  end
end
