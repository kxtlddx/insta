require 'rails_helper'

RSpec.describe 'posts/new.html.erb', type: :view do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  it 'renders the new post form' do

    render

    expect(rendered).to include('New post')
    expect(rendered).to include('Description')
    expect(rendered).to include('Images')
    expect(rendered).to include('Submit')
    end
  end