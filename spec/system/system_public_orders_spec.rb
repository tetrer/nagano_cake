require 'rails_helper'

describe 'Order関連' do

  let(:customer) { create(:customer) }
  let(:genre) { create(:genre) }
  let(:product) { create(:product, genre: genre, is_valid: true) }
  let(:cartItem) { create(:cartItem, customer_id: customer.id, product_id: product.id ) }
  let!(:order) { build(:order, customer_id: customer.id) }

  #前提として、商品をカートに入れた後に注文情報入力ページにいる
  before do
    @customer = create(:customer)
    visit new_customer_session_path
    fill_in 'customer[email]', with: @customer.email
    fill_in 'customer[password]', with: @customer.password
    click_button 'ログイン'

    visit product_path(product)
    select(value = 1, from: 'cart_item[quantity]')
    click_button 'カートに入れる'
    click_link '情報入力に進む'
  end

  describe '注文情報入力ページ' do
    context '表示内容の確認' do
      it '入力フォームがある' do
        expect(page).to have_field 'order[postal_code]'
        expect(page).to have_field 'order[address]'
        expect(page).to have_field 'order[name]'
      end
      it '確認画面へ進むリンクがある' do
        expect(page).to have_link, href: confirm_orders_path
        click_button '確認画面へ進む'
        expect(current_path).to eq '/orders/confirm'
      end
    end
  end

  describe '注文情報確認ページ' do
    before do
      click_button '確認画面へ進む'
    end

    context '表示内容の確認' do
      it '注文を確定するボタンがある' do
        expect(page).to have_link, href: complete_orders_path
        click_button '注文を確定する'
        expect(current_path).to eq '/orders/complete'
      end
    end
  end

  describe '注文確定ページ' do
    before do
      click_button '確認画面へ進む'
      click_button '注文を確定する'
    end

    context '表示内容の確認' do
      it '注文履歴はこちらボタンがある' do
        expect(page).to have_link, href: orders_path
        click_link '注文履歴はこちら'
        expect(current_path).to eq '/orders'
      end
    end
  end
end