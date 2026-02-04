class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end

    # 同じユーザーが同じ本に2回いいねできないようにする
    add_index :favorites, [ :user_id, :book_id ], unique: true
  end
end
