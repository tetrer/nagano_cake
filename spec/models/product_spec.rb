require 'rails_helper'

RSpec.describe 'Productモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { product.valid? }

    let(:genre) { create(:genre) }
    let!(:product) { build(:product, genre_id: genre.id) }

    context 'genre_idカラム' do
      it '空欄でないこと' do
        product.genre_id = ''
        is_expected.to eq false
      end
    end

    context 'nameカラム' do
      it '空欄でないこと' do
        product.name = ''
        is_expected.to eq false
      end
    end

    context 'descriptionカラム' do
      it '空欄でないこと' do
        product.description = ''
        is_expected.to eq false
      end

      it '200文字以下であること: 200文字は〇' do
        product.description = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end

      it '200文字以下であること: 201文字は×' do
        product.description = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end

    end

    context 'priceカラム' do
      it '空欄でないこと' do
        product.price = ''
        is_expected.to eq false
      end

      # it '数値のみであること' do

      # end
    end

    # context 'image_idカラム' do
    #   it '空欄でないこと' do
    #     product.image_id = ''
    #     is_expected.to eq false
    #   end
    # end
  end

  describe 'アソシエーションのテスト' do
    context 'Genreモデルとの関係' do
      it 'N:1となっている' do
        expect(Product.reflect_on_association(:genre).macro).to eq :belongs_to
      end
    end
  end

end
