FactoryBot.define do
  factory :customer do
    email { Faker::Internet.email }
    password { 'password' }
    last_name { Faker::Lorem.characters(number: 10) }
    first_name { Faker::Lorem.characters(number: 10) }
    kana_last_name { 'アアアアアアアアアア' }
    kana_first_name { 'イイイイイイイイイイ' }
    postal_code { '0000000' }
    address { '東京のどこかに住んでるよ' }
    phone_number { '08012345678' }
  end
end
