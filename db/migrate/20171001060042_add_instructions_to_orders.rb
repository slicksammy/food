class AddInstructionsToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :instructions, :text
  end
end
