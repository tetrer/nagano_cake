require 'rails_helper'

describe Admin::OrderDetailsController do
   before do
    @admin = create(:admin)
    visit new_admin_session_path
    fill_in 'admin[email]', with: 'admin@test.com'
    fill_in 'admin[password]', with: 'admin_test'
    click_button 'ログイン'
    @customer = create(:customer)
    @order = create(:order, customer: @customer)
    visit admin_order_path(@order)
  end

  describe '管理者 OrderDetails' do
    describe '注文詳細画面のテスト' do

      context '製作ステータスのテスト' do
        it '製作ステータスを1つ「製作中」にすると、注文ステータスが「製作中」に更新される' do
          
        end

        it '製作ステータスを全て「製作完了」にすると、注文ステータスが「発送待ち」に更新される' do
          
        end
      end
    end
  end
end