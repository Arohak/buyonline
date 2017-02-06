class Subcategory < ApplicationRecord
  translates :name, :title

  belongs_to :category
  has_and_belongs_to_many :restaurants

  validates_uniqueness_of :subcategory_id
end