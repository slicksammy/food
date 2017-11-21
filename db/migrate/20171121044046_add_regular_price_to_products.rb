class AddRegularPriceToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :regular_price_cents, :integer
  end
end
