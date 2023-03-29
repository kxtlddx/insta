require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
    sign_in @user
  end

  describe "GET #index" do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    let(:comment) { create(:comment) }

    it "assigns all comments as @comments" do
      expect(assigns(:comment)).to eq(@comment)
    end

  end

  describe "GET #new" do
    before do
      get :new
    end

    it "assigns @comment" do
      expect(assigns(:comment)).to be_a_new(Comment)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_attributes) { attributes_for(:comment) }

      it "creates a new Comment" do
        expect {
          post :create, params: { comment: valid_attributes }
        }.to change(Comment, :count).by(1)

        expect(response).to redirect_to(post_path(comment.post))
      end

      it "assigns a newly created comment as @comment" do
        post :create, params: { comment: valid_attributes }
        expect(assigns(:comment)).to be_a_new(Comment)
      end
    end
  end

  context "with invalid params" do
    let(:invalid_attributes) { attributes_for(:comment, text: nil) }

    it "does not create a new Comment" do
      expect {
        post :create, params: { comment: invalid_attributes }
      }.not_to change(Comment, :count)
    end
  end

  describe "DELETE #destroy" do
    let!(:comment) { create(:comment) }
    it "deletes the comment" do
      expect {
        delete :destroy, params: { id: comment.id }
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the post show page" do
      delete :destroy, params: { id: comment.id }
      expect(response).to redirect_to(post_path(comment.post))
    end
  end
end