class CartItem < ApplicationRecord
  belongs_to :product
<<<<<<< HEAD
  belongs_to :customer
  
  validates :customer_id, :product_id, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true }
=======
>>>>>>> origin/develop
end
