class AddUniqueIndexToUsersEmail < ActiveRecord::Migration[7.0]
  def change
    # 既に同じindexがあれば作らない（SQLiteの "already exists" 回避）
    add_index :users, :email, unique: true, name: "index_users_on_email" unless index_exists?(:users, :email, name: "index_users_on_email")
  end
end
