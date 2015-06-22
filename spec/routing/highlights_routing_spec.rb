require "spec_helper"

describe HighlightsController do
  describe "routing" do

    it "routes to #index" do
      get("/highlights").should route_to("highlights#index")
    end

    it "routes to #new" do
      get("/highlights/new").should route_to("highlights#new")
    end

    it "routes to #show" do
      get("/highlights/1").should route_to("highlights#show", :id => "1")
    end

    it "routes to #edit" do
      get("/highlights/1/edit").should route_to("highlights#edit", :id => "1")
    end

    it "routes to #create" do
      post("/highlights").should route_to("highlights#create")
    end

    it "routes to #update" do
      put("/highlights/1").should route_to("highlights#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/highlights/1").should route_to("highlights#destroy", :id => "1")
    end

  end
end
