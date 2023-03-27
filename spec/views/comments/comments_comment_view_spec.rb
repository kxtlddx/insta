require 'rails_helper'

RSpec.describe 'comments/show.html.erb', type: :view do
  let(:comment) { create(:comment) }

  it 'displays the comment' do
    render

    expect(rendered).to have_selector("div#comment-#{comment.user.username}", text: comment.text)
  end

  it 'renders the form' do
    render partial: 'comments/form', locals: { comment: comment }

    expect(rendered).to have_selector('form[action="/comments"][method="post"]')
  end

end