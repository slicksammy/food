class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :cart_uuid, index: true # has products
      t.integer :address_uuid # has delivery address
      t.integer :stripe_token_id # payment 
      t.integer :subtotal
      t.integer :shipping
      t.integer :tax
      t.integer :total
      t.date :expected_delivery_date
      t.timestamp :delivered_at
      t.boolean :paid
      t.string :status
      t.string :uuid, index: true

      t.timestamps
    end
  end
end
