class RemoveTitleAndKeywordsFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :title
    remove_column :posts, :keywords
  end
end
