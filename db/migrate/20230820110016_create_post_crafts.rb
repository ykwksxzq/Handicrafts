class CreatePostCrafts < ActiveRecord::Migration[6.1]
  def change
    create_table :post_crafts do |t|

      t.integer :user_id, null: false
      t.integer :genre_id, null: false
      t.string :title, null: false
      t.text :introduction, null: false
      t.integer :status, default: 0, null: false

      t.timestamps null:false
    end
  end
end
