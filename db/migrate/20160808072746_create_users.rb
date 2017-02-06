class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :image
      t.string  :email

      t.string  :mobile_number
      t.string  :verification_code
      t.boolean :is_verified

      t.timestamps null: false
    end
  end
end
