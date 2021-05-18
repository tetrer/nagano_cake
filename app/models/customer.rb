class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy

  validates :last_name, :first_name, :kana_last_name, :kana_first_name,
            :adsress, :phone_number,
            presence: true
  validates :postal_code, length: { is: 7 }, numericality: { only_integer: true }
  validates :phone_number, length: { in: 10..11 }, numericality: { only_integer: true }
  validates :kana_last_name, :kana_first_name,
            format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: "カタカナで入力して下さい。"}
end
