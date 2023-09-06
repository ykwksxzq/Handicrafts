class CreateWishLists < ActiveRecord::Migration[6.1]
  def change
    create_table :wish_lists do |t|
      t.integer :user_id, null: false
      t.integer :genre_id, null:false
      t.string :item_name, null: false
      t.text :memo
      t.timestamps null:false
    end
  end
end
