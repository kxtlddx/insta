require 'rails_helper'

RSpec.describe "posts/new.html.erb", type: :view do
  it "renders the form" do
    assign(:post, Post.new)

    render

    expect(rendered).to have_selector("form")
  end
end