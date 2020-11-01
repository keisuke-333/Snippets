class ChangeDataLanguageToPosts < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :language, "integer USING CAST(language AS integer)"
  end
end
