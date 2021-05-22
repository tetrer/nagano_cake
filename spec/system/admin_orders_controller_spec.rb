require 'rails_helper'

describe Admin::OrdersController do
  describe '管理者 Order' do

    context '注文履歴一覧画面' do
      it '注文の詳細表示ボタンを押下すると注文詳細画面が表示される' do
      end
    end


    context '注文詳細画面' do
      it '注文ステータスを「入金確認」にすると、注文ステータスが「入金確認」、製作ステータスが「製作待ち」に更新される' do
      end

      it '注文ステータスを「発送済」にすると、注文ステータスが「発送済」に更新される' do
      end

      it 'ヘッダからログアウトボタンを押下すると管理者ログイン画面に遷移する' do
      end
    end

  end
end