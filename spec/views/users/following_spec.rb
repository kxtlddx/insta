require 'rails_helper'

RSpec.describe "users/following", type: :view do
  let(:user) { create(:user) }
  let(:following1) { create(:user) }
  let(:following2) { create(:user) }

  before do
    assign(:user, user)
    assign(:following, [following1, following2])
    render
  end

  it "displays the user's username" do
    expect(rendered).to have_content(user.username)
  end

  it "displays a list of users that the current user is following" do
    expect(rendered).to have_selector(".follower-row", count: 2)
    expect(rendered).to have_content(following1.username)
    expect(rendered).to have_content(following2.username)
  end
end