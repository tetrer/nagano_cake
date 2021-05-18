# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  Admin.create!(
    email: ENV['ADMIN_MAIL'],
    password: ENV['ADMIN_PASS']
  )

4.times do |n|
    Customer.create!(
      first_name: "名#{n + 1}",
      last_name: "姓#{n + 1}",
      kana_first_name: "メイ",
      kana_last_name: "セイ",
      postal_code: "1234567",
      address: "東京都渋谷区神南1丁目19-11 パークウェースクエア24階#{n + 1}",
      phone_number: "09012345678",
      email: "test#{n + 1}@test.com",
      password: "123456"
    )
end
Genre.create!([
  {name: "ケーキ"},
  {name: "プリン"},
  {name: "焼き菓子"},
  {name: "キャンディ"}
])
  6.times do |n|
    product = Product.new(
      genre_id: 1,
      name: "ショートケーキ#{n + 1}",
      description: "大粒イチゴのショートケーキ#{n + 1}",
      price: "#{400 + (n * 50)}",
      is_valid: [['販売中', true], ['売切れ', false]],
    )
    # 画像を読みこんで、画像オブジェクトを作る。
    File.open("./app/assets/images/cake.jpg") do |file|
      product.image = file
    end
    # 画像のidを取得できる。
    product.image_id = product.image.id

    product.save
  end

  4.times do |n|
    product = Product.new(
      genre_id: 2,
      name: "プリン#{n + 1}",
      description: "口どけなめらかなプリン#{n + 1}",
      price: "#{200 + (n * 50)}",
      is_valid: [['販売中', true], ['売切れ', false]],
    )
    # 画像を読みこんで、画像オブジェクトを作る。
    File.open("./app/assets/images/pudding.jpg") do |file|
      product.image = file
    end
    # 画像のidを取得できる。
    product.image_id = product.image.id

    product.save
  end

  5.times do |n|
    product = Product.new(
      genre_id: 3,
      name: "焼き菓子#{n + 1}",
      description: "香ばしい焼き菓子#{n + 1}",
      price: "#{200 + (n * 50)}",
      is_valid: [['販売中', true], ['売切れ', false]],
    )
    # 画像を読みこんで、画像オブジェクトを作る。
    File.open("./app/assets/images/cookie.jpg") do |file|
      product.image = file
    end
    # 画像のidを取得できる。
    product.image_id = product.image.id

    product.save
  end

  3.times do |n|
    product = Product.new(
      genre_id: 4,
      name: "キャンディ#{n + 1}",
      description: "小腹が空いたときにピッタリ!#{n + 1}",
      price: "#{120 + (n * 50)}",
      is_valid: [['販売中', true], ['売切れ', false]],
    )
    # 画像を読みこんで、画像オブジェクトを作る。
    File.open("./app/assets/images/candy.jpg") do |file|
      product.image = file
    end
    # 画像のidを取得できる。
    product.image_id = product.image.id

    product.save
  end

  CartItem.create!(
    product_id: "1",
    customer_id: "1",
    quantity: "2"
  )

  CartItem.create!(
    product_id: "3",
    customer_id: "1",
    quantity: "1"
  )


  # 6.times do |n|
  #   Product.create!(
  #     name: "ショートケーキ#{n + 1}",
  #     description: "大粒イチゴのショートケーキ#{n + 1}",
  #     price: "#{400 + (n * 50)}",
  #     is_valid: [['販売中', true], ['売切れ', false]],
  #     image_id: open("./app/assets/images/cake.jpg")
  #   )
  # end

  # 4.times do |n|
  #   Product.create!(
  #     name: "プリン#{n + 1}",
  #     description: "口どけなめらかなプリン#{n + 1}",
  #     price: "#{200 + (n * 50)}",
  #     is_valid: [['販売中', true], ['売切れ', false]],
  #     image_id: open("./app/assets/images/pudding.jpg")
  #   )
  # end
  # 5.times do |n|
  #   Product.create!(
  #     name: "焼き菓子#{n + 1}",
  #     description: "香ばしい焼き菓子#{n + 1}",
  #     price: "#{200 + (n * 50)}",
  #     is_valid: [['販売中', true], ['売切れ', false]],
  #     image_id: open("./app/assets/images/cookie.jpg")
  #   )
  # end
  # 3.times do |n|
  #   Product.create!(
  #     name: "キャンディ#{n + 1}",
  #     description: "小腹が空いたときにピッタリ!#{n + 1}",
  #     price: "#{120 + (n * 50)}",
  #     is_valid: [['販売中', true], ['売切れ', false]],
  #     image_id: open("./app/assets/images/candy.jpg")
  #   )
  # end
