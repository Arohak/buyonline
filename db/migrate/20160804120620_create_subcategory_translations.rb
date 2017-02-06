class CreateSubcategoryTranslations < ActiveRecord::Migration[5.0]
  def self.up
    Subcategory.create_translation_table!({ name:   :string,
                                            title: :string},
                                          { migrate_data: true,
                                            remove_source_columns: true })
  end

  def self.down
    Subcategory.drop_translation_table! migrate_data: true
  end
end
