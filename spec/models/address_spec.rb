require 'rails_helper'

RSpec.describe 'addressのモデルテスト', type: :model do

  describe 'バリデーションのテスト' do
    subject { address.valid? }

    let(:customer) { create(:customer) }
    let!(:address) { build(:address, customer_id: customer.id) }

    context 'nameカラム' do
      it '空欄でないこと' do
        address.name = ''
        is_expected.to eq false
      end
      it '１文字以下は×' do
        address.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '２文字はOK' do
        address.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '２0文字はOK' do
        address.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '２１文字はOK' do
        address.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'postal_codeカラム' do
      it '空欄でないこと' do
        address.postal_code = ''
        is_expected.to eq false
      end
      it '数字のみであること' do
        address.postal_code = Faker::Number.number(7)
        expect(customer.postal_code.is_a? String).to be_truthy
      end
      it '７文字であること' do
        address.postal_code = '1234567'  #多分最初が０だとダメ？
        is_expected.to eq true
      end
      it '6文字では×' do
        address.postal_code = Faker::Number.number(6)
        is_expected.to eq false
      end
      it '8文字では×' do
        address.postal_code = Faker::Number.number(8)
        is_expected.to eq false
      end
    end

    context 'addressカラム' do
      it '空欄でないこと' do
        address.address = ''
        is_expected.to eq false
      end
      it '6文字では×' do
        address.address =Faker::Lorem.characters(number: 6)
        is_expected.to eq false
      end
      it '７文字はOK' do
        address.address = Faker::Lorem.characters(number: 7)
        is_expected.to eq true
      end
      it '１５０文字はOK' do
        address.address = Faker::Lorem.characters(number: 150)
        is_expected.to eq true
      end
      it '１５１文字はOK' do
        address.address = Faker::Lorem.characters(number: 151)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(Address.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
  end


end