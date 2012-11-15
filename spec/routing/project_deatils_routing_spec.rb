require "spec_helper"

describe ProjectDeatilsController do
  describe "routing" do

    it "routes to #index" do
      get("/project_deatils").should route_to("project_deatils#index")
    end

    it "routes to #new" do
      get("/project_deatils/new").should route_to("project_deatils#new")
    end

    it "routes to #show" do
      get("/project_deatils/1").should route_to("project_deatils#show", :id => "1")
    end

    it "routes to #edit" do
      get("/project_deatils/1/edit").should route_to("project_deatils#edit", :id => "1")
    end

    it "routes to #create" do
      post("/project_deatils").should route_to("project_deatils#create")
    end

    it "routes to #update" do
      put("/project_deatils/1").should route_to("project_deatils#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/project_deatils/1").should route_to("project_deatils#destroy", :id => "1")
    end

  end
end
