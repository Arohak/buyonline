class User < ApplicationRecord
  # validates_uniqueness_of :mobile_number
  # validates :mobile_number, phone: { possible: false, allow_blank: true, types: [:mobile] }

  has_many :favorites
  has_many :orders
  has_many :products, through: :favorites

end
