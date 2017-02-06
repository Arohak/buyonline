class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :product_id
      t.integer :rest_id
      t.integer :categoryitem_id
      t.integer :menu
      t.integer :restaurant_menu_categories
      t.boolean :new
      t.string  :label
      t.string  :content
      t.integer :item_number
      t.integer :inventory
      t.integer :instock
      t.integer :desired_stock
      t.string  :price
      t.string  :type_
      t.string  :alias
      t.string  :keywords
      t.string  :src
      t.boolean :favorite

      t.timestamps
    end
  end
end
