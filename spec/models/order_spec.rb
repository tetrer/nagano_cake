require 'rails_helper'

RSpec.describe 'Orderモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { order.valid? }

    let(:customer) { create(:customer) }
    let!(:order) { build(:order, customer_id: customer.id) }

  end

  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(Order.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
  end
end
