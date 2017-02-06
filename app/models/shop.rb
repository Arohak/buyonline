class Shop < ApplicationRecord
  # belongs_to :category

  validates_uniqueness_of :shop_id
end
