class AddIndexPostsTitle < ActiveRecord::Migration[6.0]
  def change
    add_index :posts, :title
  end
end
