class AddRPricesToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :r_price_cents, :integer
  end
end
