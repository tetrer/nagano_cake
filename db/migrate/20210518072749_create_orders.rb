class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :freight
      t.integer :total_price
      t.integer :payment_method
      t.string :name
      t.string :postal_code
      t.string :address
      t.integer :order_status

      t.timestamps
    end
  end
end
