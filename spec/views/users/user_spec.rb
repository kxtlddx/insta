require 'rails_helper'

RSpec.describe "users/_user", type: :view do
  let(:user) { create(:user) }

  before do
    render partial: "users/user", locals: { user: user }
  end

  it "renders the user's username" do
    expect(rendered).to have_selector("h2", text: user.username)
  end

  it "renders a link to the user's show page" do
    expect(rendered).to have_link(user.username, href: user_path(user))
  end

  context "when the user has an avatar" do
    let(:user) { create(:user, avatar: "avatar.jpg") }

    it "renders the user's avatar" do
      expect(rendered).to have_selector("img[src*='avatar.jpg']")
    end
  end

  context "when the user does not have an avatar" do
    it "does not render an avatar" do
      expect(rendered).not_to have_selector("img")
    end
  end
end