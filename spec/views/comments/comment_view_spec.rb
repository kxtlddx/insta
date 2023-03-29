require 'rails_helper'

RSpec.describe "comments/show", type: :view do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) { create(:comment, user: user, post: post) }

  before do
    assign(:comment, comment)
    render
  end

  it "displays the comment's text" do
    expect(rendered).to have_content(comment.text)
  end

  it "displays the comment's user's avatar if present" do
    if comment.user.avatar.present?
      expect(rendered).to have_css("img[src*='#{comment.user.avatar}']")
    else
      expect(rendered).to have_css("img[src*='defaultAvatar.png']")
    end
  end

  it "displays the comment's user's username" do
    expect(rendered).to have_content(comment.user.username)
  end

  it "displays a delete button if the current user is the comment's user" do
    allow(view).to receive(:current_user).and_return(user)
    render
    expect(rendered).to have_css("form[action='#{comment_path(comment)}'][method='post'] input[type='hidden'][name='_method'][value='delete']")
  end
end