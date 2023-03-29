require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  let(:post) { build(:post) }

  before do
    assign(:post, post)
    render
  end

  it "renders the form partial" do
    expect(view).to render_template(partial: "_form")
  end
end