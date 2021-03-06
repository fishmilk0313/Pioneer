class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :room_id
      t.text :body

      t.timestamps
    end
    add_index :messages, :room_id
    add_index :messages, :user_id
  end
end
