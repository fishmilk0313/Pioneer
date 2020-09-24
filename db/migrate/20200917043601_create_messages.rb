class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true, type: :integer
      t.references :room, foreign_key: true, type: :integer
      t.text :body

      t.timestamps
    end
  end
end
