require 'rails_helper'

RSpec.describe 'posts/new.html.erb', type: :view do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  it 'renders the new post form' do

    render

    expect(rendered).to have_selector('form[action="/posts"]') do |form|
      expect(form).to have_selector('input[name="post[user_id]"][type="hidden"]', visible: false)
      expect(form).to have_selector('input[name="post[description]"][type="text"]')
      expect(form).to have_selector('input[name="commit"][type="submit"]')
    end
  end
end