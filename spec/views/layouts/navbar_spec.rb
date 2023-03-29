require 'rails_helper'

RSpec.describe "layouts/_navbar", type: :view do
  let(:user) { create(:user) }

  context "when user is signed in" do
    before do
      allow(view).to receive(:user_signed_in?).and_return(true)
      allow(view).to receive(:current_user).and_return(user)
    end

    it "displays a link to the user's account" do
      render
      expect(rendered).to have_link("My account", href: user_path(user))
    end

    it "displays a link to upload a new post" do
      render
      expect(rendered).to have_link("Upload post", href: new_post_path)
    end

    it "displays a link to sign out" do
      render
      expect(rendered).to have_link("Sign out", href: destroy_user_session_path)
    end
  end

  context "when user is not signed in" do
    before do
      allow(view).to receive(:user_signed_in?).and_return(false)
    end

    it "displays a link to sign in" do
      render
      expect(rendered).to have_link("Sign in", href: user_session_path)
    end

    it "displays a link to sign up" do
      render
      expect(rendered).to have_link("Sign up", href: new_user_registration_path)
    end
  end
end