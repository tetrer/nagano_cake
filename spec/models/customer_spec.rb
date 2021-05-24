require 'rails_helper'

RSpec.describe 'customerのモデルテスト', type: :model do

  describe 'バリデーションのテスト' do
    subject { customer.valid? }
    let!(:other_customer) { create(:customer) }
    let(:customer) { build(:customer) }
    gimei = Gimei.name

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

    context 'kana_last_nameカラム' do
      it '空欄でないこと' do
        customer.last_name = ''
        is_expected.to eq false
      end
      it 'カタカナであること' do
        customer.last_name = gimei.last.katakana
        is_expected.to eq true
      end
    end

    context 'kana_first_nameカラム' do
      it '空欄でないこと' do
        customer.kana_first_name = ''
        is_expected.to eq false
      end
      it 'カタカナであること' do
        customer.kana_first_name = gimei.first.katakana
        is_expected.to eq true
      end
    end

    context 'postal_codeカラム' do
      it '空欄でないこと' do
        customer.postal_code = ''
        is_expected.to eq false
      end
      it '数字のみであること' do
        customer.postal_code = Faker::Number.number(7)
        expect(customer.postal_code.is_a? String).to be_truthy
      end
      it '７文字であること' do
        customer.postal_code = '1234567'  #多分最初が０だとダメ？
        is_expected.to eq true
      end
      it '6文字では×' do
        customer.postal_code = Faker::Number.number(6)
        is_expected.to eq false
      end
      it '8文字では×' do
        customer.postal_code = Faker::Number.number(8)
        is_expected.to eq false
      end
    end

    context 'addressカラム' do
      it '空欄でないこと' do
        customer.address = ''
        is_expected.to eq false
      end
    end

    context 'phone_numberカラム' do
      it '空欄でないこと' do
        customer.phone_number = ''
        is_expected.to eq false
      end
      it '数字のみであること' do
        customer.phone_number = Faker::Number.number(11)
        expect(customer.phone_number.is_a? String).to be_truthy
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'cart_itemモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:cart_items).macro).to eq :has_many
      end
    end
    context 'addressモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:addresses).macro).to eq :has_many
      end
    end
    context 'orderモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:orders).macro).to eq :has_many
      end
    end
  end

end


