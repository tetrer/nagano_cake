class Address < ApplicationRecord
  belongs_to :customer

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :postal_code, length: { is: 7 }, numericality: { only_integer: true }
  #日本で一番短い住所が７、長い住所が１３７らしい
  validates :address, presence: true, length: { minimum: 7, maximum: 150 }

  # orders#newで使用
	def order_address
		self.postal_code + self.address + self.name
	end
end
