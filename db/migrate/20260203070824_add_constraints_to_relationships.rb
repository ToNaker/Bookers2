class AddConstraintsToRelationships < ActiveRecord::Migration[8.0]
  def change
    change_column_null :relationships, :follower_id, false
    change_column_null :relationships, :followed_id, false

    add_foreign_key :relationships, :users, column: :follower_id
    add_foreign_key :relationships, :users, column: :followed_id

    add_index :relationships, [:follower_id, :followed_id], unique: true, if_not_exists: true
  end
end