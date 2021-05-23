require 'rails_helper'

describe 'customer関連' do

  # let(:customer) { create(:customer) }
  gimei = Gimei.name
  gimei_address = Gimei.address

  #前提として、新規登録した後にmypageにいる
  before do
    visit new_customer_registration_path
      fill_in 'customer[last_name]', with: gimei.last.kanji
      fill_in 'customer[first_name]', with: gimei.first.kanji
      fill_in 'customer[kana_last_name]', with: gimei.last.katakana
      fill_in 'customer[kana_first_name]', with: gimei.first.katakana
      fill_in 'customer[email]', with: 'rspec@test.com'
      fill_in 'customer[postal_code]', with: '1234567'
      fill_in 'customer[address]', with: gimei_address.kanji
      fill_in 'customer[phone_number]', with: '09012345678'
      fill_in 'customer[password]', with: '123456'
      fill_in 'customer[password_confirmation]', with: '123456'
      click_button '新規登録'
  end


  describe 'my_page関連' do
    context '表示内容の確認' do
      it '自分の情報が表示される' do
        expect(page).to have_content gimei.last.kanji
        expect(page).to have_content gimei.first.kanji
        expect(page).to have_content gimei.last.katakana
        expect(page).to have_content gimei.first.katakana
        expect(page).to have_content 'rspec@test.com'
        expect(page).to have_content '1234567'
        expect(page).to have_content gimei_address.kanji
        expect(page).to have_content '09012345678'
      end
      it '編集リンクがある' do
        expect(page).to have_link, href: edit_customers_path
        click_link '編集する'
        # expect(current_path).to eq '/customers/edit.' + customer.id.to_s
        expect(current_path).to eq '/customers/edit.' + '1'
      end
      it '配送先一覧リンクがある' do
        expect(page).to have_link, href: addresses_path
        click_link href: addresses_path
        expect(current_path).to eq '/addresses'
      end
      it '注文履歴一覧リンクがある' do
        expect(page).to have_link, href: orders_path
        click_link href: orders_path
        expect(current_path).to eq '/orders'
      end
    end


  end

  describe '会員編集ページ' do
    before do
      click_link '編集する'
    end

    context '表示内容の確認' do
      it '名前フォームがある' do
        expect(page).to have_field 'customer[last_name]'
        expect(page).to have_field 'customer[first_name]'
      end
      it 'フリガナフォームがある' do
        expect(page).to have_field 'customer[kana_last_name]'
        expect(page).to have_field 'customer[kana_first_name]'
      end
      it 'メールアドレスフォームがある' do
        expect(page).to have_field 'customer[email]'
      end
      it '郵便番号フォームがある' do
        expect(page).to have_field 'customer[postal_code]'
      end
      it '住所フォームがある' do
        expect(page).to have_field 'customer[address]'
      end
      it '電話番号フォームがある' do
        expect(page).to have_field 'customer[phone_number]'
      end
      it '編集内容を保存するボタンがある' do
        expect(page).to have_button '編集内容を保存'
      end
      it '退会リンクがある' do
        expect(page).to have_link, href: quit_customers_path
      end
    end

    context '編集機能のテスト' do
      it '編集内容が保持される' do
        fill_in 'customer[last_name]', with: '編集機能手酢都'
        click_button '編集内容を保存'
        expect(current_path).to eq '/customers'
        expect(page).to have_content '編集機能手酢都'
      end
    end

    context '退会機能のテスト' do
      before do
        click_link '退会する'
      end

      it '退会確認ページの表示' do
        expect(current_path).to eq '/customers/quit'
      end

      it '退会しない場合のテスト' do
        expect(page).to have_link, href: customers_path
        click_link '退会しない'
        expect(current_path).to eq '/customers'
      end

      it '退会する場合のテスト' do
        expect(page).to have_link, href: out_customers_path
        click_link '退会する'
        expect(current_path).to eq '/'
        click_link 'ログイン'
        fill_in 'customer[email]', with: 'rspec@test.com'
        fill_in 'customer[password]', with: '123456'
        click_button 'ログイン'
        expect(current_path).to eq '/customers/sign_in'
      end
    end

  end

end