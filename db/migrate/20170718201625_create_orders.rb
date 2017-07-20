class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :cart_id, index: true # has products
      t.integer :address_id # has delivery address
      t.integer :stripe_token_id # payment 
      t.integer :subtotal
      t.integer :shipping
      t.integer :tax
      t.integer :total
      t.date :expected_delivery_date
      t.timestamp :delivered_at
      t.boolean :paid

      t.timestamps
    end
  end
end
