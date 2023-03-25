require 'rails_helper'

RSpec.describe "posts/show.html.erb", type: :view do

  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:current_user) { create(:user) }

  before do
    assign(:post, post)
    render
  end

  it "displays the post" do
    expect(rendered).to include(post.description)
  end

  it "displays the 'Back to posts' link" do
    expect(rendered).to include("Back to posts")
  end

  context "when user is signed in" do
    before { sign_in user }

    it "displays the 'Destroy this post' button" do
      if post.user_id == current_user.id
        expect(rendered).to include("Destroy this post")
      end
    end

    it "displays the comment form" do
      render
      expect(rendered).to have_selector("form[action='#{comments_path}'][method='post']")
    end
  end

  context "when user is not signed in" do
    it "does not display the 'Destroy this post' button" do
      expect(rendered).not_to include("Destroy this post")
    end

    it "does not display the comment form" do
      render
      expect(rendered).not_to have_selector("form[action='#{comments_path}'][method='post']")
    end
  end
end