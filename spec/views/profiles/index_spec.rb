require 'rails_helper'

RSpec.describe "users/index", type: :view do
  it "renders a list of users" do
    users = create_list(:user, 2)
    assign(:users, users)

    render

    expect(rendered).to have_content(users.first.username)
    expect(rendered).to have_content(users.second.username)
  end
end