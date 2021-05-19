class Address < ApplicationRecord
  belongs_to :customer

  # orders#newで使用
	def order_address
		self.postal_code + self.address + self.name
	end
end
