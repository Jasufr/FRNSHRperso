class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.text :palette, array: true, default: []
      t.string :room_type
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
