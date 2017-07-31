class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :cart_uuid, index: true # has products
      t.string :address_uuid # has delivery address
      t.string :stripe_token_uuid # payment 
      t.decimal :subtotal, :precision => 6, :scale => 2
      t.decimal :shipping, :precision => 4, :scale => 2
      t.integer :tax, :precision => 5, :scale => 2
      t.integer :total, :precision => 6, :scale => 2
      t.date :expected_delivery_date
      t.timestamp :delivered_at
      t.boolean :paid
      t.string :status
      t.string :uuid, index: true

      t.timestamps
    end
  end
end
