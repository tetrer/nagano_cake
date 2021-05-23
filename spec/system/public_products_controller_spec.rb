require 'rails_helper'

describe Public::ProductsController do
   before do
    @customer = create(:admin)
    visit new_customer_session_path
    fill_in 'customer[email]', with: '1@1'
    fill_in 'customer[password]', with: '111111'
    click_button 'ログイン'

    @genre = create(:genre)
    @product = create(:product, genre: @genre)

    visit products_path
  end

  describe 'ECサイト Product' do
    describe 'トップ画面のテスト' do

      context '遷移のテスト' do
        it '任意の商品画像を押下すると該当商品の詳細画面に遷移する' do
          click_link @product.name
          expect(current_path).to eq product_path(@product)
        end
      end

      context '表示の確認' do
        it '商品情報が正しく表示されている' do
          expect(page).to have_content @product.name
          expect(page).to have_content @product.description
          expect(page).to have_content @product.price
        end

        # it '任意の商品画像を押下すると該当商品の詳細画面に遷移する(2商品目以降)' do
        # end

        # it '商品情報が正しく表示されている(2商品目以降)' do
        # end
      end
    end
  end

  describe '商品詳細画面のテスト' do
    context '遷移のテスト' do

      it '個数を選択し、カートに入れるボタンを押下するとカート画面に遷移する' do
      end

      it 'カートの中身が正しく表示されている' do
      end
      # it '個数を選択し、カートに入れるボタンを押下するとカート画面に遷移する(2商品目以降)' do
      # end
      # it 'カートの中身が正しく表示されている(2商品目以降)' do
      # end
    end
  end
end