class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :type
      t.integer :price
      t.string :color
      t.string :shop_name
      t.string :shop_item_id
      t.string :shop_url
      t.float :x_dimension
      t.float :y_dimension
      t.float :z_dimension

      t.timestamps
    end
  end
end
