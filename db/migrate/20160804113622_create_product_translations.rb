class CreateProductTranslations < ActiveRecord::Migration[5.0]
  def self.up
    Product.create_translation_table!({ label:   :string,
                                        content: :string},
                                       { migrate_data: true,
                                         remove_source_columns: true })
  end

  def self.down
    Product.drop_translation_table! migrate_data: true
  end
end
