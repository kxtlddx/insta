require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  let(:user) { create(:user) }
  let(:post) { build(:post, user: user) }

  before do
    allow(view).to receive(:current_user).and_return(user)
    assign(:post, post)
    render
  end

  it "renders new post form" do
    assert_select "form[action=?][method=?]", posts_path, "post" do
      assert_select "input[name=?]", "post[user_id]"
      assert_select "input[name=?]", "post[description]"
      assert_select "input[name=?]", "post[images][]"
    end
  end
end