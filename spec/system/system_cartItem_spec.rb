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
      @product1 = create(:product, genre: @genre)
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
      @product1 = create(:product, genre: @genre)
      @product2 = create(:product, genre: @genre)
      # @cartItem = create(:cartItem, customer: @customer)
      visit product_path(@product1)
    end
    context 'product1をカートに入れる' do
      it 'product1を１個カートに入れる：カートに移動してproduct1が１個追加される' do
        select(value = 1, from: 'cart_item[quantity]')
        click_button 'カートに入れる'
        expect(current_path).to eq cart_items_path
        expect(page).to have_content @product1.name
        expect(page).to have_content ((@product1.price * 1.1).floor).to_s(:delimited)
        find("option[value='1']").select_option
      end
    end



  end




end