require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures username presence' do
      user = User.new(email: 'test@test.com', password: 'password').save
      expect(user).to eq(false)
    end

    it 'ensures username uniqueness' do
      user1 = User.new(username: 'test', email: 'test@test.com', password: 'password').save
      user2 = User.new(username: 'test', email: 'test2@test.com', password: 'password').save
      expect(user2).to eq(false)
    end
  end

  context 'association tests' do
    it 'should have many posts' do
      t = User.reflect_on_association(:posts)
      expect(t.macro).to eq(:has_many)
    end

    it 'should have many comments' do
      t = User.reflect_on_association(:comments)
      expect(t.macro).to eq(:has_many)
    end

    it 'should have one attached avatar' do
      t = User.reflect_on_association(:avatar_attachment)
      expect(t.macro).to eq(:has_one)
    end

    it 'should have many likes' do
      t = User.reflect_on_association(:likes)
      expect(t.macro).to eq(:has_many)
    end
  end

  context '.ransackable_attributes' do
    it "returns an array of attributes that can be searched" do
      expect(User.ransackable_attributes).to eq(["username"])
    end
  end

  context '#unfollow' do
    it "removes the follow relationship between two users" do
      follower = create(:user)
      followee = create(:user)

      follower.follow(followee)

      follower.unfollow(followee)

      expect(follower.following?(followee)).to be_falsey
    end
  end

end