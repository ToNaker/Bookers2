# app/models/user.rb
class User < ApplicationRecord
  # 追記：email カラムが無い代わりに email_address を email として扱う
  alias_attribute :email, :email_address

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_one_attached :profile_image

  has_many :favorites, dependent: :destroy
  has_many :favorite_books, through: :favorites, source: :book

  has_many :book_comments, dependent: :destroy

  # ===== follow/follower（追記）=====
  has_many :active_relationships,
           class_name: "Relationship",
           foreign_key: "follower_id",
           dependent: :destroy

  has_many :passive_relationships,
           class_name: "Relationship",
           foreign_key: "followed_id",
           dependent: :destroy

  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers,  through: :passive_relationships, source: :follower

  def follow(user)
    return if user == self
    active_relationships.create!(followed_id: user.id)
  end

  def unfollow(user)
    active_relationships.find_by(followed_id: user.id)&.destroy
  end

  def following?(user)
    followings.include?(user)
  end
  # ================================

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }, allow_blank: true
  validates :email_address, presence: true, uniqueness: true
end
