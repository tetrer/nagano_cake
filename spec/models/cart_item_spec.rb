require 'rails_helper'

RSpec.describe 'cart_itemのモデルテスト', type: :model do
  subject { cartItem.valid? }

  let(:customer) { create(:customer) }
  let(:genre) { create(:genre) }
  let(:product) { create(:product, genre: genre) }
  let!(:cartItem) { build(:cartItem, customer_id: customer.id, product_id: product.id) }

  describe 'バリデーションのテスト' do
    context 'quantityカラム' do
      it 'integer型であること' do
        cartItem.quantity = 1
        is_expected.to eq true
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(CartItem.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
    context 'Productモデルとの関係' do
      it 'N:1となっている' do
        expect(CartItem.reflect_on_association(:product).macro).to eq :belongs_to
      end
    end
  end

end