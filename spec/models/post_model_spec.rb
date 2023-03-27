require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.build(:post) }

  describe 'validations' do
    it 'is invalid with description length less than 5' do
      post.description = 'a' * 4
      expect(post).not_to be_valid
    end

    it 'is invalid with description length more than 255' do
      post.description = 'a' * 256
      expect(post).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'images' do
    it 'can have many attached images' do
      post = Post.new
      file1 = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test.jpg'), 'image/jpg')
      file2 = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'test1.jpg'), 'image/jpg')
      post.images.attach(file1, file2)
      expect(post.images).to be_attached
      expect(post.images.count).to eq(2)
    end
  end
end
