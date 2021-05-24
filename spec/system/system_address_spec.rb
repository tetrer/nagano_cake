require 'rails_helper'

describe 'address関連' do
  before do
    @customer = create(:customer)
    @address = create(:address, customer: @customer)
    visit new_customer_session_path
    fill_in 'customer[email]', with: @customer.email
    fill_in 'customer[password]', with: @customer.password
    click_button 'ログイン'
    visit addresses_path
  end

  describe '表示内容の確認' do
    context '登録フォーム' do
      it '郵便番号' do
        expect(page).to have_field 'address[postal_code]'
      end
      it '住所' do
        expect(page).to have_field 'address[address]'
      end
      it '宛先' do
        expect(page).to have_field 'address[name]'
      end
      it '新規登録ボタンがある' do
        expect(page).to have_button '新規登録'
      end
    end

    context '一覧' do
      it '郵便番号' do
        expect(page).to have_content @address.postal_code
      end
      it '住所' do
        expect(page).to have_content @address.address
      end
      it '宛名' do
        expect(page).to have_content @address.name
      end
      it '編集リンク' do
        expect(page).to have_link '編集する'
      end
      it '削除リンク' do
        expect(page).to have_link '削除する'
      end
    end
  end

  describe '配送先登録のテスト' do
    context '新規登録' do
      it '登録内容の記入' do
        fill_in 'address[postal_code]', with: '7654321'
        fill_in 'address[address]', with: 'アールスペックテスト住所'
        fill_in 'address[name]', with: 'アールスペック宛名'
      end
      it '新規登録が実行できる' do
        fill_in 'address[postal_code]', with: '7654321'
        fill_in 'address[address]', with: 'アールスペックテスト住所'
        fill_in 'address[name]', with: 'アールスペック宛名'
        expect { click_button '新規登録' }.to change(Address.all, :count).by(1)
      end
    end

    context '編集のテスト' do
      before do
        click_link '編集する'
      end
      it '編集内容がn入力でき、保存できる' do
        fill_in 'address[postal_code]', with: '2222222'
        fill_in 'address[address]', with: '編集アールスペックテスト住所'
        fill_in 'address[name]', with: '編集アールスペック宛名'
        click_button '編集内容を保存'
        expect(page).to have_content '2222222'
        expect(page).to have_content '編集アールスペックテスト住所'
        expect(page).to have_content '編集アールスペック宛名'
      end
      it '保存できなかったら編集ページに留まる' do
        fill_in 'address[postal_code]', with: ''
        click_button '編集内容を保存'
        expect(current_path).to eq address_path(@address.id)
      end
    end

    context '削除のテスト' do
      it '削除が行える' do
        click_link '削除する'
        expect(page).not_to have_content @address.postal_code
      end
    end
  end
end
