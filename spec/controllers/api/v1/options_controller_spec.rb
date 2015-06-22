require 'spec_helper'

describe Api::V1::OptionsController do

  describe "GET #show" do
    before(:each) do 
      @option = FactoryGirl.create :option
      get :show, id: @option.id
    end

    it "returns the information about a reporter on a hash" do
      option_response = json_response[:option]
      expect(option_response[:title]).to eql @option.title
    end

    it "has the user as a embeded object" do
      option_response = json_response[:option]
      expect(option_response[:user][:email]).to eql @option.user.email
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :option } 
    end

    context "when is not receiving any option_ids parameter" do
      before(:each) do
        get :index
      end

      it "returns 4 records from the database" do
        options_response = json_response
        expect(options_response[:options]).to have(4).items
      end

      it "returns the user object into each option" do
        options_response = json_response[:options]
        options_response.each do |option_response|
          expect(option_response[:user]).to be_present
        end
      end

      it_behaves_like "paginated list"

      it { should respond_with 200 }
    end

    context "when option_ids parameter is sent" do
      before(:each) do
        @user = FactoryGirl.create :user
        3.times { FactoryGirl.create :option, user: @user }
        get :index, option_ids: @user.option_ids
      end

      it "returns just the options that belong to the user" do
        options_response = json_response[:options]
        options_response.each do |option_response|
          expect(option_response[:user][:email]).to eql @user.email
        end
      end
    end
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @option_attributes = FactoryGirl.attributes_for :option
        api_authorization_header user.auth_token 
        post :create, { user_id: user.id, option: @option_attributes }
      end

      it "renders the json representation for the option record just created" do
        option_response = json_response[:option]
        expect(option_response[:title]).to eql @option_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user 
        @invalid_option_attributes = { title: "Smart TV", price: "Twelve dollars" } #notice I'm not including the email
        api_authorization_header user.auth_token 
        post :create, { user_id: user.id, option: @invalid_option_attributes }
      end

      it "renders an errors json" do
        option_response = json_response
        expect(option_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        option_response = json_response
        expect(option_response[:errors][:price]).to include "is not a number"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @option = FactoryGirl.create :option, user: @user
      api_authorization_header @user.auth_token 
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @option.id, option: { title: "An expensive TV" } }
      end

      it "renders the json representation for the updated user" do
        option_response = json_response[:option]
        expect(option_response[:title]).to eql "An expensive TV"
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @option.id, option: { price: "two hundred" } }
      end

      it "renders an errors json" do
        option_response = json_response
        expect(option_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        option_response = json_response
        expect(option_response[:errors][:price]).to include "is not a number"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @option = FactoryGirl.create :option, user: @user
      api_authorization_header @user.auth_token 
      delete :destroy, { user_id: @user.id, id: @option.id }
    end

    it { should respond_with 204 }
  end

end
