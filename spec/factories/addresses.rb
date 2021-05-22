FactoryBot.define do

  factory :address do
    customer
    name { 'アドレスカラムのテスト宛先名' }
    postal_code { '1234567' }
    address { '神奈川のどこかに住んでるよ' }
  end
end
