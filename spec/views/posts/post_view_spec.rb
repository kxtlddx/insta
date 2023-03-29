require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  before do
    assign(:post, post)
    sign_in user
  end

  it "renders the post" do
    render

    expect(rendered).to have_content(post.description)
  end

  context "when the current user is the post's owner" do
    it "shows the delete button" do
      render

      expect(rendered).to have_selector("button[type='submit']")
    end
  end

  context "when the current user is not the post's owner" do
    let(:other_user) { create(:user) }

    before do
      sign_out user
      sign_in other_user
    end

    it "does not show the delete button" do
      render

      expect(rendered).not_to have_selector("button[type='submit']")
    end
  end

  it "displays the like button" do
    expect(rendered).to have_selector(".like-container .heart")
  end

  it "displays the number of likes" do
    expect(rendered).to have_selector(".like-container .like-count", text: post.likes.count.to_s)
  end

  it "displays the comment button" do
    expect(rendered).to have_selector(".like-container .material-icons", text: "comment")
  end

  it "displays the number of comments" do
    expect(rendered).to have_selector(".like-container #like-count", text: post.comments.count.to_s)
  end
end