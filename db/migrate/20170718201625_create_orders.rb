class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :cart_uuid, index: true # has products
      t.string :address_uuid # has delivery address
      t.string :stripe_token_uuid # payment 
      t.integer :subtotal_cents
      t.integer :shipping_cents
      t.integer :tax_cents
      t.integer :total_cents
      t.date :expected_delivery_date
      t.timestamp :delivered_at
      t.boolean :paid
      t.string :status
      t.string :uuid, index: true

      t.timestamps
    end
  end
end
