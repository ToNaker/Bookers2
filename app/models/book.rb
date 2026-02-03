class Book < ApplicationRecord
  belongs_to :user

  # ===== 追記：いいね / コメント =====
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    return false if user.nil?
    favorites.exists?(user_id: user.id)
  end
  # ================================

  validates :title, presence: true
  validates :body,  presence: true, length: { maximum: 200 }
end
