# app/models/user.rb
class User < ApplicationRecord
  # 追記：email カラムが無い代わりに email_address を email として扱う
  alias_attribute :email, :email_address

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_one_attached :profile_image

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }, allow_blank: true
  validates :email_address, presence: true, uniqueness: true
end
