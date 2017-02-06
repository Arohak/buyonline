class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer :restaurant_id
      t.string  :name
      t.decimal :latitude
      t.decimal :longitude
      t.decimal :distance

      t.timestamps
    end
  end
end
