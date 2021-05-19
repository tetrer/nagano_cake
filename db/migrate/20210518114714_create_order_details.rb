class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :quantity
      t.integer :subtotal_price
      t.integer :production_status

      t.timestamps
    end
  end
end
