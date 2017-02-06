class Product < ApplicationRecord
  translates :label, :content

  belongs_to :categoryitem
  has_many :favorites
  has_many :users, through: :favorites

  def self.search(search)
    where("keywords LIKE ?", "%#{search}%")
  end

end