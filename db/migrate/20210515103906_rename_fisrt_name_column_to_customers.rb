class RenameFisrtNameColumnToCustomers < ActiveRecord::Migration[5.2]
  def change
    rename_column :customers, :fisrt_name, :first_name
    rename_column :customers, :kana_fisrt_name, :kana_first_name
  end
end
