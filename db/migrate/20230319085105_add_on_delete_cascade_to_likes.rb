class AddOnDeleteCascadeToLikes < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :likes, :users
    add_foreign_key :likes, :users, on_delete: :cascade
  end
end
