class RenameKanaFisrtNameColumnToCustomers < ActiveRecord::Migration[5.2]
  def change
    rename_column :customers, :kana_fisrt_name, :kana_first_name
  end
end
