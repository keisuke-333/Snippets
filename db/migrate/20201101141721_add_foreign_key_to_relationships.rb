class AddForeignKeyToRelationships < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :relationships, :users, column: :following_id
    add_foreign_key :relationships, :users, column: :follower_id
  end
end
