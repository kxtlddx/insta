require 'rails_helper'

describe UsersController do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe "GET #show" do
    it "assigns the requested user as @user" do
      get :show, params: { id: other_user.id }
      expect(assigns(:user)).to eq(other_user)
    end

    it "assigns the user's posts as @posts in reverse chronological order" do
      post1 = FactoryBot.create(:post, user: other_user, created_at: 1.day.ago)
      post2 = FactoryBot.create(:post, user: other_user)
      get :show, params: { id: other_user.id }
      expect(assigns(:posts)).to eq([post2, post1])
    end
  end

  describe "GET #index" do
    it "assigns all users as @users" do
      get :index
      expect(assigns(:users)).to match_array([user, other_user])
    end
  end

  describe "POST #follow" do
    it "creates a follow relationship between the current user and the other user" do
      expect {
        post :follow, params: { id: other_user.id }
      }.to change(user.following, :count).by(1)
    end

  end

  describe "DELETE #unfollow" do
    before do
      user.follow(other_user)
    end

    it "deletes the follow relationship between the current user and the other user" do
      expect {
        delete :unfollow, params: { id: other_user.id }
      }.to change(user.following, :count).by(-1)
    end

  end

  describe "GET #followers" do
    before do
      other_user.follow(user)
    end

    it "assigns the requested user as @user" do
      get :followers, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it "assigns the user's followers as @followers" do
      get :followers, params: { id: user.id }
      expect(assigns(:followers)).to eq(other_user)
    end
  end

  describe "GET #following" do
    before do
      user.follow(other_user)
    end

    it "assigns the requested user as @user" do
      get :following, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it "assigns the users that the user is following as @following" do
      get :following, params: { id: user.id }
      expect(assigns(:following)).to eq([other_user])
    end
  end
end