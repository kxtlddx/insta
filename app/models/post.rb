class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255, minimum: 5 }
  validates :description, presence: true, length: { maximum: 255, minimum: 5 }
  validates :keywords, presence: true, length: { maximum: 255, minimum: 5 }
  has_many_attached :images
  belongs_to :user
  has_many :comments
  has_many :likes
end
