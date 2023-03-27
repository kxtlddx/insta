require 'rails_helper'

RSpec.describe "posts/show.html.erb", type: :view do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  before do
    assign(:post, post)
    render
  end

  it "displays the post" do
    expect(rendered).to include(post.description)
  end

  it "displays the post images" do
    post.images.each do |image|
      expect(rendered).to include(image.url)
    end
  end

  it "displays the post likes count" do
    expect(rendered).to include(post.likes.count.to_s)
  end

  it "displays the post comments" do
    post.comments.each do |comment|
      expect(rendered).to include(comment.body)
    end
  end
end