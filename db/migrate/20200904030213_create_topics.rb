class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|

    t.integer :category_id, foreign_key: true
    t.string :title, null: false
    t.text :text, null:false
    t.string :image_id

      t.timestamps
    end
  end
end
