FactoryBot.define do
  factory :product do
    genre_id { 1 }
    name { "MyString" }
    description { "MyString" }
    price { 1 }
    image_id { "MyString" }
    is_valid { false }
  end

end
