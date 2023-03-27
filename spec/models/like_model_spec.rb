require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'validations' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    before do
      Like.create(user: user, post: post)
    end

    it { should validate_uniqueness_of(:user_id).scoped_to(:post_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'creating a new like' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    it 'sets the user_id to a valid value' do
      like = Like.create(user: user, post: post)
      expect(like.user_id).to eq(user.id)
    end
  end
end