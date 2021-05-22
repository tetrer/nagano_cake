require 'rails_helper'

RSpec.describe 'OrderDetailのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { order_detail.valid? }

    let(:order) { create(:order) }
    let(:product) { create(:product) }
    let!(:order_detail) { build(:order_detail, order_id: order.id) }
    let!(:order_detail) { build(:order_detail, product_id: product.id) }

  end

  describe 'アソシエーションのテスト' do
    context 'Orderモデルとの関係' do
      it 'N:1となっている' do
        expect(OrderDetail.reflect_on_association(:order).macro).to eq :belongs_to
      end
    end

    context 'Productモデルとの関係' do
      it 'N:1となっている' do
        expect(OrderDetail.reflect_on_association(:product).macro).to eq :belongs_to
      end
    end
  end
end
