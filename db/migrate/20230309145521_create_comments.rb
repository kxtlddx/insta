class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :text
      t.bigint :user_id
      t.bigint :post_id

      t.timestamps
    end
  end
end
