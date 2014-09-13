require "spec_helper"

describe ClassSessionsController do
  describe "routing" do

    it "routes to #index" do
      get("/class_sessions").should route_to("class_sessions#index")
    end

    it "routes to #new" do
      get("/class_sessions/new").should route_to("class_sessions#new")
    end

    it "routes to #show" do
      get("/class_sessions/1").should route_to("class_sessions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/class_sessions/1/edit").should route_to("class_sessions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/class_sessions").should route_to("class_sessions#create")
    end

    it "routes to #update" do
      put("/class_sessions/1").should route_to("class_sessions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/class_sessions/1").should route_to("class_sessions#destroy", :id => "1")
    end

  end
end
