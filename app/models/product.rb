class Product < ApplicationRecord
  belongs_to :genre
	has_many :cartItems
	has_many :orders, through: :order_details
	has_many :order_details

	attachment :image

	# validates :name, :price, presence: true
	# validates :description, length: { maximum: 200 }
	# validates :price, numericality: { only_integer: true }
end
