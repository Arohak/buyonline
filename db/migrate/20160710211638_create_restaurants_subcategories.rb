class CreateRestaurantsSubcategories < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants_subcategories, id: false do |t|
      t.integer :restaurant_id
      t.integer :subcategory_id
    end
  end
end
