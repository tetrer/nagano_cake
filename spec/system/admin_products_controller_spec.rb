require 'rails_helper'

describe Admin::ProductsController do
  describe '管理者 Product' do

    context '商品一覧画面' do
      it '新規登録ボタンを押下すると商品新規登録画面が表示される' do
      end

      it '登録した商品が表示されている' do
      end

      # it '新規登録ボタンを押下すると商品新規登録画面が表示される(2商品目)' do
      # end

      # it '登録した商品が表示されている' do
      # end

      it 'ヘッダからログアウトボタンをクリックすると管理者ログイン画面に遷移する' do
      end
    end


    context '商品新規登録画面' do
      it '必要事項を入力して登録ボタンを押下すると登録した商品の詳細画面に遷移する' do
      end

      # it '必要事項を入力して登録ボタンを押下すると登録した商品の詳細画面に遷移する(2商品目)' do
      # end
    end

    context '商品詳細画面' do
      it 'ヘッダから商品一覧へのリンクを押下すると商品一覧画面が表示される' do
      end

      # it 'ヘッダから商品一覧へのリンクを押下すると商品一覧画面が表示される(2商品目)' do
      # end

    end
  end
end