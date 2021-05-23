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
        expect(page).to have_content @customer1.id
      end
      it 'カスタマー名' do
        expect(page).to have_content @customer1.last_name
      end
      it 'メールアドレス' do
        expect(page).to have_content @customer1.email
      end
      it '会員ステータス' do
        expect(page).to have_content '有効'
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

  describe 'showページ' do
    before do
      click_link href: admin_customer_path(@customer1)
    end

    context '表示内容の確認' do
      it 'カスタマーid' do
        expect(page).to have_content @customer1.id
      end
      it 'カスタマー名' do
        expect(page).to have_content @customer1.last_name
      end
      it 'フリガナ' do
        expect(page).to have_content @customer1.kana_last_name
      end
      it '郵便番号' do
        expect(page).to have_content @customer1.postal_code
      end
      it '住所' do
        expect(page).to have_content @customer1.address
      end
      it '電話番号' do
        expect(page).to have_content @customer1.phone_number
      end
      it 'メールアドレス' do
        expect(page).to have_content @customer1.email
      end
      it '会員ステータス' do
        expect(page).to have_content '有効'
      end
      it '編集リンク' do
        expect(page).to have_link, href: edit_admin_customer_path(@customer1)
      end
      it '注文履歴一覧リンク' do
        expect(page).to have_link, href: admin_orders_path(@customer1)
      end
    end
  end

  describe 'editページ' do
    before do
      click_link href: admin_customer_path(@customer1)
      click_link href: edit_admin_customer_path(@customer1)
    end
    context '表示内容の確認' do
      it '名前フォームがある' do
        expect(page).to have_field 'adminCustomerLastName'
        expect(page).to have_field 'adminCustomerFirstName'
      end
      it 'フリガナフォームがある' do
        expect(page).to have_field 'adminCustomerKanaLastName'
        expect(page).to have_field 'adminCustomerKanaFirstName'
      end
      it '郵便番号フォームがある' do
        expect(page).to have_field 'adminCustomerPostalCode'
      end
      it '住所フォームがある' do
        expect(page).to have_field 'adminCustomerAddress'
      end
      it '電話番号フォームがある' do
        expect(page).to have_field 'adminCustomerPhoneNumber'
      end
      it 'メールアドレスフォームがある' do
        expect(page).to have_field 'adminCustomerEmail'
      end
      it '会員ステータスの切り替えボタンがある' do
        choose "customer_is_deleted_true"     #存在確認の処理が不明なため、ボタンを押せることで確認
        choose "customer_is_deleted_false"
      end
      context '編集処理の確認' do
        it '編集成功の確認' do
          fill_in 'adminCustomerLastName', with: '編集成功'
          click_button 'Update'
          expect(current_path).to eq admin_customer_path(@customer1)
          expect(page).to have_content '編集成功'
        end
        it '編集失敗の確認' do
          fill_in 'adminCustomerLastName', with: ''
          click_button 'Update'
          expect(current_path).to eq admin_customer_path(@customer1)
        end
      end
    end
  end
end