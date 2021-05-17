class Product < ApplicationRecord

  has_many :cartItems

  attachment :image
end
