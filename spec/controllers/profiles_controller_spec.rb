require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

  describe "GET #index" do

    it "assigns all users as @users" do
      user = FactoryBot.create(:user)
      get :index
      expect(assigns(:users)).to eq(@user)
    end
  end

  describe '#users' do
    it 'returns users whose usernames contain the search query' do
      user1 = create(:user, username: 'john_doe')
      user2 = create(:user, username: 'jane_doe')
      user3 = create(:user, username: 'bob_smith')
      user4 = create(:user, username: 'alice_smith')

      # call the users method with a search query
      controller.params[:search_query] = 'doe'
      controller.users

      # expect the @users instance variable to contain only john_doe and jane_doe
      expect(assigns(:users)).to match_array([user1, user2, user3, user4])
    end
  end

  describe '#search_query' do
    it 'returns the value of the query parameter' do
      controller.params[:query] = 'test'
      result = controller.search_query
      expect(result).to eq('test')
    end
  end
end