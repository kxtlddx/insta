class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  followability

  validates :username, presence: true
  validates_uniqueness_of :username
  has_many :posts
  has_many :comments
  has_one_attached :avatar
  has_many :likes

  def self.ransackable_attributes(auth_object = nil)
    # Add the attributes you want to allow for searching here
    ["username"]
  end

  def unfollow(user)
    followerable_relationships.where(followable_id: user.id).destroy_all
  end

  def follow(user)
  end

end

