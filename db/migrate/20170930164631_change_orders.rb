class ChangeOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :paid, :boolean
    add_column :orders, :promotion_id, :integer
    add_column :orders, :discount_cents, :integer
  end
end
