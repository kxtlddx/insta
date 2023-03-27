require 'rails_helper'

RSpec.describe 'comments/new.html.erb', type: :view do
  let(:comment) { build(:comment) }

  before do
    assign(:comment, comment)
    render
  end

  it 'displays the form' do
    expect(rendered).to have_selector('form[action="/comments"][method="post"]') do |form|
      expect(form).to have_selector('input[name="comment[text]"]')
      expect(form).to have_selector('input[type="submit"]')
    end
  end

  context 'when user is signed in' do
    before { sign_in create(:user) }

    it 'displays a link to go back to comments' do
      expect(rendered).to have_link('Back to comments', href: :back)
    end
  end

  context 'when user is not signed in' do
    it 'does not display a link to go back to comments' do
      expect(rendered).not_to have_link('Back to comments', href: :back)
    end
  end
end