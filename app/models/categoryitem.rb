class Categoryitem < ApplicationRecord
  translates :name

  belongs_to :restaurant
  has_many :products

end