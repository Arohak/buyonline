class CreateDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveries do |t|
      t.string  :city
      t.string  :alias
      t.integer :price

      t.timestamps
    end
  end
end
