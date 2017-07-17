class CreateCartsProductsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_table :carts_products do |t|
      t.integer :cart_id, index: true
      t.integer :product_id, index: true
      t.decimal :amount, precision: 4, scale: 2

      t.timestamps
    end
  end
end
