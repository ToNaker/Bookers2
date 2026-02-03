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

  # ===== search（追記）=====
  def self.search_for(word, method)
    word = word.to_s
    escaped = sanitize_sql_like(word)

    case method
    when "perfect"
      where(title: word).or(where(body: word))
    when "forward"
      where("title LIKE ? OR body LIKE ?", "#{escaped}%", "#{escaped}%")
    when "backward"
      where("title LIKE ? OR body LIKE ?", "%#{escaped}", "%#{escaped}")
    else # "partial"
      where("title LIKE ? OR body LIKE ?", "%#{escaped}%", "%#{escaped}%")
    end
  end
  # =======================

  validates :title, presence: true
  validates :body,  presence: true, length: { maximum: 200 }
end
