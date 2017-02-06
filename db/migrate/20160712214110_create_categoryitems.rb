class CreateCategoryitems < ActiveRecord::Migration[5.0]
  def change
    create_table :categoryitems do |t|
      t.integer :categoryitem_id
      t.integer :rest_id
      t.integer :restaurant_id
      t.string  :name

      t.timestamps
    end
  end
end
