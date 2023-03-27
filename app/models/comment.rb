class Comment < ApplicationRecord
  validates :text, presence: true, length: { maximum: 255, minimum: 5 }
  belongs_to :post
  belongs_to :user
  scope :most_recent, -> { order(created_at: :desc).limit(1) }
end
