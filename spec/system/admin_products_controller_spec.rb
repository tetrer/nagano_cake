require 'rails_helper'

describe Admin::ProductsController do
  before do
    @admin = create(:admin)
    visit new_admin_session_path
    fill_in 'admin[email]', with: 'admin@test.com'
    fill_in 'admin[password]', with: 'admin_test'
    click_button 'ログイン'

    @genre = create(:genre)
    @product = create(:product, genre: @genre)

    visit admin_products_path
  end

  describe '管理者 Productのテスト' do
    describe '商品一覧画面のテスト' do

      context '表示の確認' do
        it '新規登録ボタンを押下すると商品新規登録画面が表示される' do
          click_link href: new_admin_product_path
          expect(current_path).to eq('/admin/products/new')
        end

        it '登録した商品が表示されている' do
          expect(page).to have_content @product.name
          expect(page).to have_content @product.price
        end

      end

      context '遷移先の確認' do
        it 'ヘッダからログアウトボタンをクリックすると管理者ログイン画面に遷移する' do
          logout_link = find_all('a')[5].native.inner_text
          click_link logout_link
          expect(current_path).to eq '/admins/sign_in'
        end
      end
    end

    describe '商品新規登録画面のテスト' do
      context '遷移先の確認' do
        before do
          click_link href: new_admin_product_path
          expect(current_path).to eq('/admin/products/new')

        end

        it '必要事項を入力して登録ボタンを押下すると登録した商品の詳細画面に遷移する' do
          # fill_in 'product[name]', with: Faker::Lorem.characters(number: 9)
          # fill_in 'product[description]', with: Faker::Lorem.characters(number: 19)
          # fill_in 'product[price]', with: Faker::Lorem.characters(number: 4)
          # click_button '新規登録'
          # expect(current_path).to eq('/admin/product/1')
        end

        # it '必要事項を入力して登録ボタンを押下すると登録した商品の詳細画面に遷移する(2商品目)' do
        # end
      end
    end

    describe '商品詳細画面のテスト' do
      context '商品詳細画面' do
        it 'ヘッダから商品一覧へのリンクを押下すると商品一覧画面が表示される' do
          admin_products_link = find_all('a')[1].native.inner_text
          click_link admin_products_link
          expect(current_path).to eq '/admin/products'
        end

      end
    end
  end
end