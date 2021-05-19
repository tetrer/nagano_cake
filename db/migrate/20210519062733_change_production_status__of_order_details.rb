class ChangeProductionStatusOfOrderDetails < ActiveRecord::Migration[5.2]
  def change
    change_column :order_details, :production_status, :integer, default: 0, null: false
  end
end
