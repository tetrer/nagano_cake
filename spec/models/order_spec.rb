require 'rails_helper'

RSpec.describe 'Orderのモデルテスト', type: :model do

  describe 'バリデーションのテスト' do
    subject { order.valid? }

    let(:customer) { create(:customer) }
    let!(:order) { build(:order, customer_id: customer.id) }

    context 'nameカラム' do
      it '空欄でないこと' do
        order.name = ''
        is_expected.to eq false
      end
    end

    context 'postal_codeカラム' do
      it '空欄でないこと' do
        order.postal_code = ''
        is_expected.to eq false
      end
      it '数字のみであること' do
        order.postal_code = Faker::Number.number(digits: 7)
        expect(order.postal_code.is_a? String).to be_truthy
      end
      it '７文字であること' do
        order.postal_code = '1234567'
        is_expected.to eq true
      end
      it '6文字では×' do
        order.postal_code = Faker::Number.number(digits: 6)
        is_expected.to eq false
      end
      it '8文字では×' do
        order.postal_code = Faker::Number.number(digits: 8)
        is_expected.to eq false
      end
    end

    context 'addressカラム' do
      it '空欄でないこと' do
        order.address = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'OrderDetailモデルとの関係' do
      it '1:Nとなっている' do
        expect(Order.reflect_on_association(:order_details).macro).to eq :has_many
      end
    end
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(Order.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
  end

end
