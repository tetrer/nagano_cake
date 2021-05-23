require 'rails_helper'

describe 'admin/customer関連' do
  before do
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @admin = create(:admin)
    visit new_admin_session_path
    fill_in 'admin[email]', with: @admin.email
    fill_in 'admin[password]', with: @admin.password
    click_button 'ログイン'
    visit admin_customers_path
  end

  describe 'indexページ' do
    context '表示内容の確認' do
      it 'ページタイトル' do
        expect(page).to have_content '会員一覧'
      end
      it 'カスタマーid' do
        expect(page).to have_content @customer1.customer_id
      end
      it 'カスタマー名' do
        expect(page).to have_content @customer1.last_name
      end
      it 'メールアドレス' do
        expect(page).to have_content @customer1.email
      end
      it '会員ステータス' do
        expect(page).to have_content @customer1.is_deleted
      end
    end

    context 'カスタマーごとのリンク' do
      it '一人目のリンク' do
        expect(page).to have_link, href: admin_customer_path(@customer1)
      end
      it '二人目のリンク' do
        expect(page).to have_link, href: admin_customer_path(@customer2)
      end
    end

  end

end