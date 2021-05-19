class ChangeFreightOfOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :freight, :integer, default: 800
    change_column :orders, :payment_method, :integer, default: 0
    change_column :orders, :order_status, :integer, default: 0
  end
end
