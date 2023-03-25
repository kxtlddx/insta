require 'rails_helper'

RSpec.describe 'posts/show', type: :view do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  before do
    assign(:post, post)
    assign(:user, user)
    render
  end

  it 'displays the post' do
    expect(rendered).to include(post.description)
    expect(rendered).to include(user.username)
    expect(rendered).to include(post.images.first.filename.to_s)
    expect(rendered).to have_link(user.username, href: user_path(user))
    expect(rendered).to have_link('', href: post_path(post))
  end
end
