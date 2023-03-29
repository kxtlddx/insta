require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  let(:post) { create(:post) }

  before do
    assign(:post, post)
    render
  end

  it "renders the post partial" do
    expect(view).to render_template(partial: "_post")
  end

end