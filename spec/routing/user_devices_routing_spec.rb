require "spec_helper"

describe UserDevicesController do
  describe "routing" do

    it "routes to #index" do
      get("/user_devices").should route_to("user_devices#index")
    end

    it "routes to #new" do
      get("/user_devices/new").should route_to("user_devices#new")
    end

    it "routes to #show" do
      get("/user_devices/1").should route_to("user_devices#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_devices/1/edit").should route_to("user_devices#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_devices").should route_to("user_devices#create")
    end

    it "routes to #update" do
      put("/user_devices/1").should route_to("user_devices#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_devices/1").should route_to("user_devices#destroy", :id => "1")
    end

  end
end
