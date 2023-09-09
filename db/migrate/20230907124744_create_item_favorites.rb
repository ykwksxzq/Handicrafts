class CreateItemFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :item_favorites do |t|
      t.integer :user_id
      t.integer :item_list_id

      t.timestamps
    end
  end
end
