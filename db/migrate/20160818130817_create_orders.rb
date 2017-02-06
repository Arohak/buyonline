class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string  :title
      t.string  :date_create
      t.string  :mobile_number
      t.string  :delivery_address
      t.string  :delivery_city
      t.string  :delivery_alias
      t.string  :delivery_date
      t.string  :payment
      t.decimal :orders_total_price
      t.decimal :delivery_price
      t.decimal :total_price
      t.boolean :is_verified

      t.timestamps null: false
    end
  end
end
