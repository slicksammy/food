class AddProductsToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :products, :string
  end
end
