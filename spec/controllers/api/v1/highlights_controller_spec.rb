require 'spec_helper'

describe Api::V1::HighlightsController do

  describe "GET #index" do
    before(:each) do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.authentication_token
      4.times { FactoryGirl.create :highlight, user: current_user }
      get :index, user_id: current_user.id
    end

    it "returns 4 highlight records from the user" do
      highlights_response = json_response[:highlights]
      expect(highlights_response).to have(4).items
    end

    it_behaves_like "paginated list"

    it { should respond_with 200 }
  end

  describe "GET #show" do
    before(:each) do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.authentication_token

      @option = FactoryGirl.create :option
      @highlight = FactoryGirl.create :highlight, user: current_user, option_ids: [@option.id]
      get :show, user_id: current_user.id, id: @highlight.id
    end

    it "returns the user highlight record matching the id" do
      highlight_response = json_response[:highlight]
      expect(highlight_response[:id]).to eql @highlight.id
    end

    it "includes the total for the highlight" do
      highlight_response = json_response[:highlight]
      expect(highlight_response[:total]).to eql @highlight.total.to_s
    end

    it "includes the options on the highlight" do
      highlight_response = json_response[:highlight]
      expect(highlight_response[:options]).to have(1).item
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    before(:each) do
      current_user = FactoryGirl.create :user
      api_authorization_header current_user.authentication_token

      option_1 = FactoryGirl.create :option
      option_2 = FactoryGirl.create :option
      highlight_params = { option_ids_and_quantities: [[option_1.id, 2],[ option_2.id, 3]] }
      post :create, user_id: current_user.id, highlight: highlight_params
    end

    it "returns just user highlight record" do
      highlight_response = json_response[:highlight]
      expect(highlight_response[:id]).to be_present
    end

    it "embeds the two option objects related to the highlight" do
      highlight_response = json_response[:highlight]
      expect(highlight_response[:options].size).to eql 2
    end

    it { should respond_with 201 }
  end

end
