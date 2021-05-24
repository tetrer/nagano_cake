FactoryBot.define do
  factory :order_detail do
    quantity { 5 }
    subtotal_price { 2340 }
    production_status { 0 }
    customer
    order
  end
end
