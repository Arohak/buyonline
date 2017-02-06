class CreateDeliveryaddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveryaddresses do |t|
      t.integer :user_id
      t.string  :country
      t.string  :city
      t.string  :alias
      t.string  :address
      t.boolean :def

      t.timestamps
    end
  end
end
