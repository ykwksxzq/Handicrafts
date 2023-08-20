class CreateItemListComments < ActiveRecord::Migration[6.1]
  def change
    create_table :item_list_comments do |t|
      t.integer :user_id, null:false
      t.integer :item_list_id, null:false
      t.text :comment, null:false

      t.timestamps null:false
    end
  end
end
