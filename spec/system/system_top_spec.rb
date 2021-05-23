require 'rails_helper'

describe 'ログイン前' do
  
  gimei = Gimei.name
  gimei_address = Gimei.address

  describe 'Topページ関連' do

    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'aboutへのリンクがある' do
        click_link 'About'
        expect(current_path).to eq '/about'
      end
      it '商品詳細へのリンクがある' do
        all('#product_link')[0]
      end
    end
  end

  describe 'カスタマー新規登録のテスト' do

    before do
      visit new_customer_registration_path
    end

    context '表示内容の確認' do
      it '表示内容の確認' do
        expect(current_path).to eq '/customers/sign_up'
      end
      it '「新規会員登録」と表示される' do
        expect(page).to have_content '新規会員登録'
      end
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
      it 'パスワードフォームがある' do
        expect(page).to have_field 'customer[password]'
      end
      it 'パスワード確認フォームがある' do
        expect(page).to have_field 'customer[password_confirmation]'
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end

    context '新規登録のテスト' do
      before do
        fill_in 'customer[last_name]', with: gimei.last.kanji
        fill_in 'customer[first_name]', with: gimei.first.kanji
        fill_in 'customer[kana_last_name]', with: gimei.last.katakana
        fill_in 'customer[kana_first_name]', with: gimei.first.katakana
        fill_in 'customer[email]', with: Faker::Internet.email
        fill_in 'customer[postal_code]', with: '1234567'
        fill_in 'customer[address]', with: gimei_address.kanji
        fill_in 'customer[phone_number]', with: '09012345678'
        fill_in 'customer[password]', with: '123456'
        fill_in 'customer[password_confirmation]', with: '123456'
      end

      it '正しく新規登録される' do
        expect { click_button '新規登録' }.to change(Customer.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたカスタマーの詳細画面になっている' do
        click_button '新規登録'
        expect(current_path).to eq '/customers'
      end
    end
  end

  describe 'カスタマーのログイン' do
    let(:customer) { create(:customer) }
    before do
      visit new_customer_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'customer[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'customer[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'customer[email]', with: customer.email
        fill_in 'customer[password]', with: customer.password
        click_button 'ログイン'
      end
      it 'ログイン後のリダイレクト先が、Topページになっている' do
        expect(current_path).to eq '/'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'customer[email]', with: ''
        fill_in 'customer[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/customers/sign_in'
      end
    end
  end

  describe 'ヘッダーの内容:ログインした状態' do
    let(:customer) { create(:customer) }
    before do
      visit new_customer_session_path
      fill_in 'customer[email]', with: customer.email
      fill_in 'customer[password]', with: customer.password
      click_button 'ログイン'
    end

    context 'ヘッダーの表示を確認' do
      it 'Homeリンクが表示される: 左上のリンクが「Home」である' do
        home_link = find_all('a')[0].native.inner_text
        expect(home_link).to match "ながのCAKE"
      end
      it 'マイページへのリンクが表示される' do
        my_page_link = find_all('a')[1].native.inner_text
        expect(my_page_link).to match "マイページ"
      end
      it '商品一覧へのリンクが表示される' do
        products_link = find_all('a')[2].native.inner_text
        expect(products_link).to match "商品一覧"
      end
      it 'カートへのリンクが表示される' do
        cart_link = find_all('a')[3].native.inner_text
        expect(cart_link).to match "カート"
      end
      it 'ログアウトのリンクが表示される' do
        logout_link = find_all('a')[4].native.inner_text
        expect(logout_link).to match "ログアウト"
      end
    end
  end

  describe 'ログアウトのテスト' do
    let(:customer) { create(:customer) }
    before do
      visit new_customer_session_path
      fill_in 'customer[email]', with: customer.email
      fill_in 'customer[password]', with: customer.password
      click_button 'ログイン'
      logout_link = find_all('a')[4].native.inner_text
      click_link logout_link
    end

    context 'ログアウト機能' do
      it 'ログアウトしたらトップページにいく' do
        expect(current_path).to eq '/'
      end
    end
  end
end