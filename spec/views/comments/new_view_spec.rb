require 'rails_helper'

RSpec.describe "comments/new", type: :view do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) { create(:comment, user: user, post: post) }

  before do
    assign(:comment, comment)
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(user)
  end

  it "displays the comment text and user_id" do
    render
    expect(rendered).to match(/#{comment.text}/)
    expect(rendered).to match(/#{comment.user_id}/)
  end
end