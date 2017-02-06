class CreateShops < ActiveRecord::Migration[5.0]
  def change
    create_table :shops do |t|
      t.integer :shop_id
      t.integer :category_id
      t.integer :rate
      t.string  :budget
      t.boolean :new
      t.integer :min_amount_order
      t.text    :hash_
      t.integer :position
      t.text    :description
      t.string  :label
      t.integer :totalHours
      t.string  :openTime
      t.string  :closeTime
      t.integer :around
      t.string  :status
      t.string  :src

      t.timestamps
    end
  end
end
