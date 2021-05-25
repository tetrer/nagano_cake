class Product < ApplicationRecord
  belongs_to :genre
	has_many :cart_items
	has_many :orders, through: :order_details
	has_many :order_details

	attachment :image

  validates :genre_id, :name, :price, presence: true
	validates :description, length: { maximum: 200 }, presence: true
	validates :price, numericality: { only_integer: true }

	def self.looks(word)
		@product = Product.where("name LIKE?","%#{word}%")
	end
end
