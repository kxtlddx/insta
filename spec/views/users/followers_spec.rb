require 'rails_helper'

RSpec.describe "users/followers", type: :view do
  let(:user) { create(:user) }
  let(:follower1) { create(:user) }
  let(:follower2) { create(:user) }

  before do
    assign(:user, user)
    assign(:followers, [follower1, follower2])
    render
  end

  it "displays the user's username" do
    expect(rendered).to have_content(user.username)
  end

  it "displays a list of the user's followers" do
    expect(rendered).to have_selector(".follower-row", count: 2)
    expect(rendered).to have_content(follower1.username)
    expect(rendered).to have_content(follower2.username)
  end
end