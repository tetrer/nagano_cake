class Product < ApplicationRecord
  belongs_to :genre
  has_many :cartItems

  attachment :image

  validates :genre_id, :name, :price, presence: true
	validates :description, length: { maximum: 200 }
	validates :price, numericality: { only_integer: true }

end
