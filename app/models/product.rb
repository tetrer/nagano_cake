class Product < ApplicationRecord
  belongs_to :genre
  has_many :cartItems
  attachment :image
end
