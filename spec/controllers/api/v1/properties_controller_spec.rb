require 'spec_helper'

describe Api::V1::PropertiesController do

  describe "GET #index" do
    before(:each) do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.authentication_token
      4.times { FactoryGirl.create :property, user: current_user }
      get :index, user_id: current_user.id
    end

    it "returns 4 property records from the user" do
      properties_response = json_response[:properties]
      expect(properties_response).to have(4).items
    end

    it_behaves_like "paginated list"

    it { should respond_with 200 }
  end

  describe "GET #show" do
    before(:each) do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.authentication_token

      @beacon = FactoryGirl.create :beacon
      @property = FactoryGirl.create :property, user: current_user, beacon_ids: [@beacon.id]
      get :show, user_id: current_user.id, id: @property.id
    end

    it "returns the user property record matching the id" do
      property_response = json_response[:property]
      expect(property_response[:id]).to eql @property.id
    end

    it "includes the total for the property" do
      property_response = json_response[:property]
      expect(property_response[:total]).to eql @property.total.to_s
    end

    it "includes the beacons on the property" do
      property_response = json_response[:property]
      expect(property_response[:beacons]).to have(1).item
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    before(:each) do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.authentication_token

      beacon_1 = FactoryGirl.create :beacon
      pbeacon_2 = FactoryGirl.create :beacon
      property_params = { beacon_ids_and_quantities: [[beacon_1.id, 2],[ beacon_2.id, 3]] }
      post :create, user_id: current_user.id, property: property_params
    end

    it "returns just user property record" do
      property_response = json_response[:property]
      expect(property_response[:id]).to be_present
    end

    it "embeds the two beacon objects related to the property" do
      property_response = json_response[:property]
      expect(property_response[:beacons].size).to eql 2
    end

    it { should respond_with 201 }
  end

end
