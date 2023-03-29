require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  before do
    assign(:post, post)
    render
  end

  it "displays the first image of the post" do
    expect(rendered).to have_css("img[src='#{post.images.first.url}']")
  end

  it "has a link to the post" do
    expect(rendered).to have_link("", href: post_path(post))
  end
end