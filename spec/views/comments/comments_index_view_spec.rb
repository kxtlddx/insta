require 'rails_helper'

RSpec.describe 'comments/index.html.erb', type: :view do
  let(:comments) { create_list(:comment, 3) }

  before do
    assign(:comments, comments)
    render
  end

  it 'displays the comments' do
    expect(rendered).to have_selector('#comments') do |comments_div|
      comments.each do |comment|
        expect(comments_div).to have_selector("#comment-#{comment.id}")
      end
    end
  end
end