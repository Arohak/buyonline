class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.integer :restaurant_id
      t.string  :label
      t.text    :description
      t.text    :hash_
      t.string  :status
      t.integer :position
      t.string  :budget
      t.string  :openTime
      t.string  :closeTime
      t.string  :src
      t.integer :min_amount_order
      t.integer :rate
      t.integer :totalHours
      t.integer :around
      t.boolean :new

      t.timestamps
    end
  end
end
