# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  #管理者
  Admin.create!(
    email: ENV['ADMIN_MAIL'],
    password: ENV['ADMIN_PASS']
  )

  #会員サンプル
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

  #退会した会員サンプル
  Customer.create!(
    first_name: "志多男",
    last_name: "大海",
    kana_first_name: "シタオ",
    kana_last_name: "タイカイ",
    postal_code: "1234567",
    address: "退会都退会区退会町1丁目12-34",
    phone_number: "08012345678",
    email: "taikai@test.com",
    password: "123456",
    is_deleted: true
  )

  #住所サンプル
  4.times do |n|
    n = n + 1
    Address.create!(
      customer_id: n,
      name: "姓#{n}名#{n}のおばあちゃん",
      postal_code: "1234567",
      address: "最果県田舎市草原町１丁目10-#{n}"
    )
  end

  #デフォルトのジャンル
  Genre.create!([
    {name: "ケーキ"},
    {name: "プリン"},
    {name: "焼き菓子"},
    {name: "キャンディ"}
  ])

  # 商品サンプル
  2.times do |n|
    n = n + 1
    product = Product.new(
      genre_id: 1,
      name: "ショートケーキ#{n}",
      description: "大粒イチゴのショートケーキ#{n}",
      price: 400 + (n * 50),
      is_valid: true                                          #trueは販売中、falseは販売停止
    )
    File.open("./app/assets/images/cake#{n}.jpg") do |file|   # 画像を読みこんで、画像オブジェクトを作る。
      product.image = file
    end
    product.image_id = product.image.id                       # 画像のidを取得できる。
    product.save
  end

  2.times do |n|
    n = n + 1
    m = n + 2
    product = Product.new(
      genre_id: 1,
      name: "チョコレートケーキ#{m}",
      description: "チョコ好きにはたまらないチョコレートケーキ#{m}",
      price: 350 + (m * 50),
      is_valid: true
    )
    File.open("./app/assets/images/cake#{m}.jpg") do |file|
      product.image = file
    end
    product.image_id = product.image.id
    product.save
  end

  #販売停止商品サンプル(安くしすぎて在庫無くなっちゃった設定)
  product = Product.new(
    genre_id: 1,
    name: "チーズケーキ5",
    description: "コスパが良いと大好評なチーズケーキ",
    price: 180,
    is_valid: false
  )
  File.open("./app/assets/images/cake5.jpg") do |file|
    product.image = file
  end
  product.image_id = product.image.id
  product.save

  4.times do |n|
    n = n + 1
    product = Product.new(
      genre_id: 2,
      name: "プリン#{n}",
      description: "口どけなめらかなプリン#{n}",
      price: 200 + (n * 50),
    )
    File.open("./app/assets/images/pudding.jpg") do |file|
      product.image = file
    end
    product.image_id = product.image.id
    product.save
  end

  5.times do |n|
    n = n + 1
    product = Product.new(
      genre_id: 3,
      name: "焼き菓子#{n}",
      description: "香ばしい焼き菓子#{n}",
      price: 200 + (n * 50),
      is_valid: true
    )
    File.open("./app/assets/images/cookie.jpg") do |file|
      product.image = file
    end
    product.image_id = product.image.id
    product.save
  end

  3.times do |n|
    n = n + 1
    product = Product.new(
      genre_id: 4,
      name: "キャンディ#{n}",
      description: "小腹が空いたときにピッタリ!#{n}",
      price: 120 + (n * 50),
      is_valid: true
    )
    File.open("./app/assets/images/candy.jpg") do |file|
      product.image = file
    end
    product.image_id = product.image.id
    product.save
  end

  #カートサンプル
  CartItem.create!(
    product_id: 1,
    customer_id: 1,
    quantity: 2
  )

  CartItem.create!(
    product_id: 3,
    customer_id: 1,
    quantity: 1
  )

  #注文履歴サンプル
  Order.create!(
    customer_id: 1,
    total_price: 2340,
    payment_method: 0,
    name: "姓1名1",
    postal_code: "1234567",
    address: "東京都渋谷区神南1丁目19-11 パークウェースクエア24階1",
    order_status: "入金待ち"
  )
  OrderDetail.create!(
    order_id: 1,
    product_id: 1,
    quantity: 2,
    subtotal_price: 990
  )
  OrderDetail.create!(
    order_id: 1,
    product_id: 3,
    quantity: 1,
    subtotal_price: 550
  )

