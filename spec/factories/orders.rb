FactoryBot.define do
  factory :order do
    customer_id { 1 }
    freight { 1 }
    total_price { 1 }
    payment_method { 1 }
    name { "MyString" }
    postal_code { "MyString" }
    address { "MyString" }
    order_status { 1 }
  end
end
