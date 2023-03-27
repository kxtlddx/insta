require 'rails_helper'

RSpec.describe 'comments/show.html.erb', type: :view do
  let(:comment) { create(:comment) }

  before do
    assign(:comment, comment)
    render
  end

  it 'displays the comment' do
    expect(rendered).to have_selector('#comment') do |comment_div|
      expect(comment_div).to have_content(comment.text)
      expect(comment_div).to have_content(comment.user.email)
    end
  end

  context 'when user is signed in' do
    before { sign_in comment.user }

    it 'displays a button to destroy the comment' do
      expect(rendered).to have_button('Destroy this comment')
    end
  end

  context 'when user is not signed in' do
    it 'does not display a button to destroy the comment' do
      expect(rendered).not_to have_button('Destroy this comment')
    end
  end

  it 'displays a link to go back to post' do
    expect(rendered).to have_link('Back to post', href: :back)
  end
end