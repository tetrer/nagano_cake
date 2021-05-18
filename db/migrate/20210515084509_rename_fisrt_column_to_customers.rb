class RenameFisrtColumnToCustomers < ActiveRecord::Migration[5.2]
  def change
    rename_column :customers, :fisrt_name, :first_name
  end
end
