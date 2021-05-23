require 'rails_helper'

describe 'customer関連' do
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

    end

  end

end