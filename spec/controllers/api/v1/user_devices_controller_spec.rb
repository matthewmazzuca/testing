require 'spec_helper'

describe Api::V1::UserDevicesController do

  describe "GET #index" do
    before(:each) do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.authentication_token
      FactoryGirl.create :user_device, user: current_user
      get :index, user_id: current_user.id
    end

    it "returns 4 user_device records from the user" do
      user_devices_response = json_response[:user_devices]
      expect(user_devices_response).to have(4).items
    end

    it_behaves_like "paginated list"

    it { should respond_with 200 }
  end

  describe "GET #show" do
    before(:each) do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.authentication_token

      # @product = FactoryGirl.create :product
      @user_device = FactoryGirl.create :user_device, user: current_user, product_ids: [@product.id]
      get :show, user_id: current_user.id, id: @user_device.id
    end

    it "returns the user user_device record matching the id" do
      user_device_response = json_response[:user_device]
      expect(user_device_response[:id]).to eql @user_device.id
    end

    it "includes the total for the user_device" do
      user_device_response = json_response[:user_device]
      expect(user_device_response[:total]).to eql @user_device.total.to_s
    end

    # it "includes the products on the user_device" do
    #   user_device_response = json_response[:user_device]
    #   expect(user_device_response[:products]).to have(1).item
    # end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    before(:each) do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.authentication_token

      # product_1 = FactoryGirl.create :product
      # product_2 = FactoryGirl.create :product
      # user_device_params = { product_ids_and_quantities: [[product_1.id, 2],[ product_2.id, 3]] }
      post :create, user_id: current_user.id, user_device: user_device_params
    end

    it "returns just user user_device record" do
      user_device_response = json_response[:user_device]
      expect(user_device_response[:id]).to be_present
    end

    # it "embeds the two product objects related to the order" do
    #   user_device_response = json_response[:user_device]
    #   expect(user_device_response[:products].size).to eql 2
    # end

    it { should respond_with 201 }
  end

end
