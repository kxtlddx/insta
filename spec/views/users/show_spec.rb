require 'rails_helper'

RSpec.describe "users/show", type: :view do
  let(:user) { create(:user) }
  let(:follower1) { create(:user) }
  let(:follower2) { create(:user) }
  let(:post1) { create(:post, user: user) }
  let(:post2) { create(:post, user: user) }
  let(:following1) { create(:user) }
  let(:following2) { create(:user) }

  before do
    assign(:user, user)
    assign(:posts, [post1, post2])
    assign(:followers, [follower1, follower2])
    assign(:following, [following1, following2])
    render
  end

  it "displays the user's username" do
    expect(rendered).to have_content(user.username)
  end

  it "displays the user's bio" do
    expect(rendered).to have_content(user.bio)
  end

  context "when the current user is viewing their own profile" do
    let(:current_user) { user }

    it "displays an 'Edit profile' button" do
      expect(rendered).to have_link("Edit profile", href: edit_user_registration_path)
    end
  end

  context "when the current user is viewing another user's profile" do
    let(:current_user) { create(:user) }

    context "when the current user is following the viewed user" do
      before do
        current_user.follow(user)
        render
      end

      it "displays an 'Unfollow' button" do
        expect(rendered).to have_button("Unfollow")
      end
    end

    context "when the current user is not following the viewed user" do
      it "displays a 'Follow' button" do
        expect(rendered).to have_button("Follow")
      end
    end
    it "displays the number of posts" do
      expect(rendered).to have_content("Posts")
      expect(rendered).to have_content(user.posts.count)
    end

    it "displays the number of followers" do
      expect(rendered).to have_content("Followers")
      expect(rendered).to have_content(user.followers.count)
    end

    it "displays the number of following" do
      expect(rendered).to have_content("Following")
      expect(rendered).to have_content(user.following.count)
    end

    it "displays a list of the user's posts" do
      expect(rendered).to have_selector(".post_at_account", count: 2)
    end
  end
end