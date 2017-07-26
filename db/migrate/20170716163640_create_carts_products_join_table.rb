class CreateCartsProductsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_table :carts_products do |t|
      t.string :cart_uuid, index: true
      t.string :product_uuid, index: true
      t.integer :amount

      t.timestamps
    end
  end
end
