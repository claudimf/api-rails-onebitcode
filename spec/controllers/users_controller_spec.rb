require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'User logged in ' do
    before(:each) do
      http_login
    end

    let(:valid_attributes) {
      {
        email: "teste@teste.com",
        password: "password",
        name: "Administrador"
      }
    }

    let(:invalid_attributes) {
      {
        email: "aaaa",
        password: "",
        name: ""
      }
    }

    let(:valid_session) { {} }

    describe "GET #index" do
      it "returns a success response" do
        User.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(response).to be_successful
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        user = User.create! valid_attributes
        get :show, params: {id: user.to_param}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  context "User not logged" do
    it "can't access action index and be redirected(status 302)" do
      get(:index)
      expect(response).to have_http_status(302)
    end

    it "can't access action index and be redirected to 'sign_in'" do
      get(:index)
      expect(response.location).to eq("http://test.host/users/sign_in")
    end
  end
end
