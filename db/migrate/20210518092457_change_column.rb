class ChangeColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :email, :string, null: false, default: ""
    change_column :customers, :encrypted_password, :string, null: false, default: ""

    change_column :customers, :last_name, :string, null: false
    change_column :customers, :first_name, :string, null: false
    change_column :customers, :kana_last_name, :string, null: false
    change_column :customers, :kana_first_name, :string, null: false
    change_column :customers, :postal_code, :string, null: false
    change_column :customers, :address, :string, null: false
    change_column :customers, :phone_number, :string, null: false
    change_column :customers, :is_deleted, :boolean, null: false, default: false
    change_column :customers, :created_at, :datetime, null: false
    change_column :customers, :updated_at, :datetime, null: false


  end
end
