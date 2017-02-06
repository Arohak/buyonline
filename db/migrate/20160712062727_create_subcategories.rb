class CreateSubcategories < ActiveRecord::Migration[5.0]
  def change
    create_table :subcategories do |t|
      t.integer :category_id
      t.integer :subcategory_id
      t.string  :name
      t.string  :title
      t.integer :position
      t.string  :src

      t.timestamps
    end
  end
end
