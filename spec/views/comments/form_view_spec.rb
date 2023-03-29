require 'rails_helper'

RSpec.describe "comments/new", type: :view do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) { build(:comment, user: user, post: post) }

  before do
    assign(:comment, comment)
    allow(view).to receive(:current_user).and_return(user)
    render
  end

  it "displays the current user's avatar if present" do
    if current_user.avatar.present?
      expect(rendered).to have_css("img[src*='#{current_user.avatar}']")
    else
      expect(rendered).to have_css("img[src*='defaultAvatar.png']")
    end
  end

  it "displays the current user's username" do
    expect(rendered).to have_content(user.username)
  end

  it "displays a form to create a new comment" do
    expect(rendered).to have_css("form[id='comment-form'][action='#{comments_path}'][method='post']")
    expect(rendered).to have_css("form textarea[name='comment[text]']")
    expect(rendered).to have_css("form input[type='hidden'][name='comment[user_id]'][value='#{user.id}']")
    expect(rendered).to have_css("form input[type='hidden'][name='comment[post_id]'][value='#{post.id}']")
  end

  it "displays a checkmark icon to submit the form" do
    expect(rendered).to have_css("i.material-icons", text: "checkmark")
  end

  context "when the comment is invalid" do
    let(:comment) { build(:comment, text: nil, user: user, post: post) }

    before do
      comment.validate
      render
    end

    it "displays validation errors" do
      expect(rendered).to have_content(comment.errors.full_messages_for(:text).join(","))
    end
  end
end