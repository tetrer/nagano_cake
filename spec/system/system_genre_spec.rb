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
    end
    context '一覧' do
      it 
    end
  end

end