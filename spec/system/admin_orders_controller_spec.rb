require 'rails_helper'

describe Admin::OrdersController do
  before do
    @admin = create(:admin)
    visit new_admin_session_path
    fill_in 'admin[email]', with: 'admin@test.com'
    fill_in 'admin[password]', with: 'admin_test'
    click_button 'ログイン'
    @customer = create(:customer)
    @order = create(:order, customer: @customer)
    visit admin_orders_path
  end

  describe '管理者 Order' do
    describe '注文履歴一覧画のテスト' do

      context '表示の確認' do
        it '注文の詳細表示ボタンを押下すると注文詳細画面が表示される' do
          click_link href: admin_order_path(@order)
          expect(current_path).to eq('/admin/orders/1')
        end
      end
    end

    describe '注文詳細画面のテスト' do
      before do
        visit admin_order_path(@order)
      end

      context '注文ステータスのテスト' do
        it '注文ステータスを「入金確認」にすると、注文ステータスが「入金確認」、製作ステータスが「製作待ち」に更新される' do

        end

        it '注文ステータスを「発送済」にすると、注文ステータスが「発送済」に更新される' do

        end

        it 'ヘッダからログアウトボタンを押下すると管理者ログイン画面に遷移する' do

        end
      end
    end
  end
end