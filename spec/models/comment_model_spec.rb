require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.build(:comment) }

  describe 'validations' do
    it 'has a valid factory' do
      expect(comment).to be_valid
    end

    it 'is invalid without text' do
      comment.text = nil
      expect(comment).not_to be_valid
    end

    it 'is invalid with text length less than 5' do
      comment.text = 'a' * 4
      expect(comment).not_to be_valid
    end

    it 'is invalid with text length more than 255' do
      comment.text = 'a' * 256
      expect(comment).not_to be_valid
    end

    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end