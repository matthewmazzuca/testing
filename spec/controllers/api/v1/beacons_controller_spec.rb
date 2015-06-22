require 'spec_helper'

describe Api::V1::BeaconsController do

  describe "GET #show" do
    before(:each) do 
      @beacon = FactoryGirl.create :beacon
      get :show, id: @beacon.id
    end

    it "returns the information about a reporter on a hash" do
      beacon_response = json_response[:beacon]
      expect(beacon_response[:name]).to eql @beacon.name
    end

    it "has the user as a embeded object" do
      beacon_response = json_response[:beacon]
      expect(beacon_response[:user][:email]).to eql @beacon.user.email
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :beacon } 
    end

    context "when is not receiving any beacon_ids parameter" do
      before(:each) do
        get :index
      end

      it "returns 4 records from the database" do
        beacons_response = json_response
        expect(beacons_response[:beacons]).to have(4).items
      end

      it "returns the user object into each beacon" do
        beacons_response = json_response[:beacons]
        beacons_response.each do |beacon_response|
          expect(beacon_response[:user]).to be_present
        end
      end

      it_behaves_like "paginated list"

      it { should respond_with 200 }
    end

    context "when beacon_ids parameter is sent" do
      before(:each) do
        @user = FactoryGirl.create :user
        3.times { FactoryGirl.create :beacon, user: @user }
        get :index, beacon_ids: @user.beacon_ids
      end

      it "returns just the beacons that belong to the user" do
        beacons_response = json_response[:beacons]
        beacons_response.each do |beacon_response|
          expect(beacon_response[:user][:email]).to eql @user.email
        end
      end
    end
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @beacon_attributes = FactoryGirl.attributes_for :beacon
        api_authorization_header user.authentication_token 
        post :create, { user_id: user.id, beacon: @beacon_attributes }
      end

      it "renders the json representation for the beacon record just created" do
        beacon_response = json_response[:beacon]
        expect(beacon_response[:name]).to eql @beacon_attributes[:name]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user 
        @invalid_beacon_attributes = { name: "Smart TV", price: "Twelve dollars" } #notice I'm not including the email
        api_authorization_header user.authentication_token 
        post :create, { user_id: user.id, beacon: @invalid_beacon_attributes }
      end

      it "renders an errors json" do
        beacon_response = json_response
        expect(beacon_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        beacon_response = json_response
        expect(beacon_response[:errors][:price]).to include "is not a number"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @beacon = FactoryGirl.create :beacon, user: @user
      api_authorization_header @user.authentication_token 
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @beacon.id, beacon: { name: "An expensive TV" } }
      end

      it "renders the json representation for the updated user" do
        beacon_response = json_response[:beacon]
        expect(beacon_response[:name]).to eql "An expensive TV"
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @beacon.id, beacon: { price: "two hundred" } }
      end

      it "renders an errors json" do
        beacon_response = json_response
        expect(beacon_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        beacon_response = json_response
        expect(beacon_response[:errors][:price]).to include "is not a number"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @beacon = FactoryGirl.create :beacon, user: @user
      api_authorization_header @user.authentication_token 
      delete :destroy, { user_id: @user.id, id: @beacon.id }
    end

    it { should respond_with 204 }
  end

end
