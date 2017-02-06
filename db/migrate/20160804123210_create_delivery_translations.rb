class CreateDeliveryTranslations < ActiveRecord::Migration[5.0]
  def self.up
    Delivery.create_translation_table!({ city: :string },
                                       { migrate_data: true,
                                         remove_source_columns: true })
  end

  def self.down
    Delivery.drop_translation_table! migrate_data: true
  end
end
