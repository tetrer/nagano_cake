# frozen_string_literal: true

require 'rails_helper'

describe 'ジャンル関連' do
  before do
    @admin = create(:admin)
    @genre = create(:genre)
    visit new_admin_session_path
    fill_in 'admin[email]', with: @admin.email
    fill_in 'admin[password]', with: @admin.password
    click_button 'ログイン'
    visit admin_genres_path
  end

  describe '表示内容の確認' do

    context '新規登録フォーム' do
      it 'ジャンル名' do
        expect(page).to have_field 'genre[name]'
      end
      it '新規登録ボタンがある' do
        expect(page).to have_button '新規登録'
      end
    end

    context '一覧' do
      it 'ジャンル名' do
        expect(page).to have_content @genre.name
      end
      it '編集リンク' do
        expect(page).to have_link '編集する'
      end
    end
  end

end