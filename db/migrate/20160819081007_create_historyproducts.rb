class CreateHistoryproducts < ActiveRecord::Migration[5.0]
  def change
    create_table :historyproducts do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :count_buy

    end
  end
end
