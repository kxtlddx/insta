require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  let(:user) { create(:user) }
  let(:posts) { create_list(:post, 3, user: user) }

  before do
    assign(:posts, posts)
  end

  context "when user is signed in" do
    before do
      sign_in user
      render
    end

    it "displays the posts" do
      posts.each do |post|
        expect(rendered).to have_selector("#posts-container", text: post.description)
      end
    end
  end

  context "when user is not signed in" do
    before do
      render
    end

    it "displays the sign up message" do
      expect(rendered).to have_selector("div", text: "Sign up!")
    end

    it "displays the default avatar image" do
      expect(rendered).to have_selector("img[src*='defaultAvatar.png']")
    end

    it "displays the username" do
      expect(rendered).to have_selector(".nav-link", text: "ipostcats")
    end

    it "displays the description" do
      expect(rendered).to have_selector(".description", text: 'The AI is honestly gonna kill us all! Those cats are cute though..')
    end

    it "displays the kittens image" do
      expect(rendered).to have_selector("img[src*='kittens.png']")
    end
  end
end