require 'rails_helper'

describe Public::ProductsController do
  before do
    @customer = create(:customer)
    visit new_customer_session_path
    fill_in 'customer[email]', with: '1@1'
    fill_in 'customer[password]', with: '111111'
    click_button 'ログイン'

    @genre = create(:genre)
    @product = create(:product, genre: @genre, is_valid: true)
    visit products_path
  end

  describe 'ECサイト Product' do
    describe 'トップ画面のテスト' do

      context '遷移のテスト' do
        it '任意の商品画像を押下すると該当商品の詳細画面に遷移する' do
          click_link @product.image_id
          expect(current_path).to eq product_path(@product)
        end
      end

      context '表示の確認' do
        it '商品情報が正しく表示されている' do
          expect(page).to have_content @product.name
          expect(page).to have_content @product.price
        end

      end
    end
  end

  describe '商品詳細画面のテスト' do
    before do
      click_link @product.image_id

      visit product_path(@product)
    end

    context '遷移のテスト' do
      it '個数を選択し、カートに入れるボタンを押下するとカート画面に遷移する' do
        expect(current_path).to eq product_path(@product)
        select(value = 1, from: 'cart_item[quantity]')
        # click_button 'カートに入れる'
        # expect(current_path).to eq cart_items_path
        # expect(page).to have_content 'こちらの商品は、只今売り切れです。'
      end

      # it 'カートの中身が正しく表示されている' do
      #   expect(current_path).to eq cart_items_path
      # end

    end
  end
end