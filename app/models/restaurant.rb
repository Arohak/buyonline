class Restaurant < ApplicationRecord
  translates :label, :description

  has_and_belongs_to_many :subcategories
  has_many :categoryitems
  has_many :addresses

  validates_uniqueness_of :restaurant_id

  def self.search(search)
    where("label LIKE ?", "%#{search}%")
    where("description LIKE ?", "%#{search}%")
  end
end
