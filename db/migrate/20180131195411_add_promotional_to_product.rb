class AddPromotionalToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :promotional, :boolean
  end
end
