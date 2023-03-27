require 'rails_helper'

RSpec.describe 'comments/new.html.erb', type: :view do
  let(:comment) { build(:comment) }

  it 'displays the form' do
    render

    expect(rendered).to have_selector('form[action="/comments"][method="post"]') do |form|
      expect(form).to have_selector('input[name="comment[text]"]')
      expect(form).to have_selector('input[type="submit"]')
    end
  end
end