FactoryBot.define do
  factory :order do
    total_price { "2340" }
    payment_method { "クレジットカード" }
    name { Gimei.name }
    postal_code { '0000000' }
    address { '東京のどこかに住んでるよ' }
    order_status { "入金待ち" }
    customer
  end
end
