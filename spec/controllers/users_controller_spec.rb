require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe "GET #show" do
    it "returns http success" do
      sign_in user
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #follow" do
    it "redirects to users_path(@user)" do
      sign_in user
      post :follow, params: { id: user.id }
      expect(response).to redirect_to(users_path(user))
    end
  end

  describe "POST #unfollow" do
    it "redirects to users_path(@user)" do
      sign_in user
      post :unfollow, params: { id: user.id }
      expect(response).to redirect_to(users_path(user))
    end
  end

end
