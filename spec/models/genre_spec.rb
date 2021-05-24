require 'rails_helper'

RSpec.describe 'genreのモデルテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { genre.valid? }
    let(:genre) {create(:genre)}
    context 'nameカラム' do
      it '空欄でないこと' do
        genre.name = ''
        is_expected.to eq false
      end
    end
  end
end