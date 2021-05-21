require 'rails_helper'

RSpec.describe 'customerのモデルテスト', type: :model do


  describe 'バリデーションのテスト' do
    subject { customer.valid? }
    let!(:other_customer) { create(:customer) }
    let(:customer) { build(:customer) }

    context 'last_nameカラム' do
      it '空欄でないこと' do
        customer.last_name = ''
        is_expected.to eq false
      end
    end

    context 'first_nameカラム' do
      it '空欄でないこと' do
        customer.first_name = ''
        is_expected.to eq false
      end
    end


  end
end
