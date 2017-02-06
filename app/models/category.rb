class Category < ApplicationRecord
  translates :name

  has_many :subcategories

end
