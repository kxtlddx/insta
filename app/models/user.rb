class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :username, presence: true
  validates_uniqueness_of :username
  has_many :posts
  has_many :comments
  has_one_attached :avatar
  has_many :likes
  has_many :subscriptions
  has_many :subscribers

  def unfollow(user)
    followerable_relationships.where(followable_id: user.id).destroy_all
  end

end

