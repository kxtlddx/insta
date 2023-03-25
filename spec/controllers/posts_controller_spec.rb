require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  before do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe "GET #index" do
    let(:current_user) { create(:user) }
    let(:following_user) { create(:user) }
    let!(:post) { create(:post, user: following_user) }

    before do
      sign_in current_user
      current_user.follow(following_user)
      get :index
    end

    it "assigns @following_users" do
      expect(assigns(:following_user)).to eq(@following_user)
    end

    it "assigns @posts" do
      expect(assigns(:post)).to eq(@post)
    end

  end

  describe "GET #show" do
    let(:post) { create(:post) }

    before do
      get :show, params: { id: post.id }
    end

    it "assigns @post" do
      expect(assigns(:post)).to eq(post)
    end

    it "assigns @comment" do
      expect(assigns(:comment)).to be_a_new(Comment)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    before do
      get :new
    end

    it "assigns @post" do
      expect(assigns(:post)).to be_a_new(Post)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_attributes) { attributes_for(:post) }

      it "creates a new Post" do
        expect {
          post :create, params: { post: valid_attributes }
        }.to change(Post, :count).by(1)
      end

      it "assigns a newly created post as @post" do
        post :create, params: { post: valid_attributes }
        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:post)).to be_persisted
      end

      it "redirects to the created post" do
        post :create, params: { post: valid_attributes }
        expect(response).to redirect_to(Post.last)
      end

    end

    context "with invalid params" do
      let(:invalid_attributes) { attributes_for(:post, description: nil) }

      it "does not create a new Post" do
        expect {
          post :create, params: { post: invalid_attributes }
        }.not_to change(Post, :count)
      end

      it "renders the new template" do
        post :create, params: { post: invalid_attributes }
        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:post) { create(:post) }

    it "destroys the requested post" do
      expect {
        delete :destroy, params: { id: post.id }
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      delete :destroy, params: { id: post.id }
      expect(response).to redirect_to(posts_url)
    end
  end

end