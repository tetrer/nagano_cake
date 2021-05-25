require 'rails_helper'

describe 'cartItem関連' do
  before do
    @customer = create(:customer)
    visit new_customer_session_path
    fill_in 'customer[email]', with: @customer.email
    fill_in 'customer[password]', with: @customer.password
    click_button 'ログイン'
  end

  describe 'cart_itemsページ' do
    before do
      @genre = create(:genre)
      @product1 = create(:product, genre: @genre, is_valid: true)
      @cartItem = create(:cartItem, customer: @customer)
      visit cart_items_path
    end

    context '表示内容の確認' do
      it 'ショッピングカートの文字' do
        expect(page).to have_content 'ショッピングカート'
      end
      it 'カートを空にするためのリンク' do
        expect(page).to have_link 'カートを空にする'
      end
      it '商品名' do
        expect(page).to have_content @cartItem.product.name
      end
      it '単価' do
        expect(page).to have_content ((@cartItem.product.price * 1.1).floor).to_s(:delimited)
      end
      it '数量' do
        expect(page).to have_content @cartItem.quantity
      end
      it '小計' do
        expect(page).to have_content ((@cartItem.quantity * @cartItem.product.price * 1.1).floor).to_s(:delimited)
      end
      it '削除リンク' do
        expect(page).to have_link 'X 削除する'
      end
      it '商品一覧リンク' do
        expect(page).to have_link '買い物を続ける'
      end
      it '合計金額' do
        expect(page).to have_content @subtotal
      end
      it '情報入力へのリンク' do
        expect(page).to have_link '情報入力に進む'
      end
    end
  end

  describe '商品をカートに入れる' do
    before do
      @genre = create(:genre)
      @product1 = create(:product, genre: @genre, is_valid: true)
      @product2 = create(:product, genre: @genre, is_valid: true)
      visit product_path(@product1)
    end
    context 'productそれぞれをカートに入れる' do
      it 'product1を１個カートに入れる：カートに移動してproduct1が１個追加される' do
        select(value = 1, from: 'cart_item[quantity]')
        click_button 'カートに入れる'
        expect(current_path).to eq cart_items_path
        expect(page).to have_content @product1.name
        expect(page).to have_content ((@product1.price * 1.1).floor).to_s(:delimited)
        find("option[value='1']").select_option
      end
      it '既に別の商品が入っていても別の商品が追加される：合計金額が正確に反映される' do
        select(value = 1, from: 'cart_item[quantity]')
        click_button 'カートに入れる'
        visit product_path(@product2)
        select(value = 3, from: 'cart_item[quantity]')
        click_button 'カートに入れる'
        expect(current_path).to eq cart_items_path
        expect(page).to have_content @product1.name
        expect(page).to have_content @product2.name
        expect(page).to have_content @subtotal
      end
      it '同じ商品が入った場合、合算される' do
        select(value = 1, from: 'cart_item[quantity]')
        click_button 'カートに入れる'
        visit product_path(@product1)
        select(value = 1, from: 'cart_item[quantity]')
        click_button 'カートに入れる'
        find("option[value='3']").select_option
      end
    end
  end

  describe '削除機能' do
    before do
      @genre = create(:genre)
      @product1 = create(:product, genre: @genre, is_valid: true)
      @product2 = create(:product, genre: @genre, is_valid: true)
      visit product_path(@product1)
      select(value = 1, from: 'cart_item[quantity]')
      click_button 'カートに入れる'
    end

    context 'カートに入れた商品を削除できる' do
      it '個別で削除する' do
        click_link 'X 削除する'
        expect(page).not_to have_content @product1.name
        expect(page).to have_content 'カートの中身がありません'
      end
      it '複数の商品を一括で削除する' do
        visit product_path(@product2)
        select(value = 1, from: 'cart_item[quantity]')
        click_button 'カートに入れる'
        click_link 'カートを空にする'
        expect(page).not_to have_content @product1.name
        expect(page).not_to have_content @product2.name
        expect(page).to have_content 'カートの中身がありません'
      end
    end
  end
end

