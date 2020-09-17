class CreateNotifications < ActiveRecord::Migration[5.2]
   def change
    create_table :notifications do |t|
      t.references :visitor, foreign_key:{ to_table: :users }, null: false
      t.references :visited, foreign_key:{ to_table: :users }, null: false
      t.references :post, foregin_key: true
      t.references :comment, foregin_key: true
      t.references :room, foreign_key: true
      t.references :message, foreign_key:true
      t.string :action, null: false
      t.boolean :checked, null: false, default: false


      t.timestamps
    end
  end
end