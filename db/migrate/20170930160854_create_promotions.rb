class CreatePromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :promotions do |t|
      t.string :code, null: false
      t.integer :minimum_order_cents, default: 0
      t.string :discount, null: false
      t.boolean :expired

      t.timestamps
    end

    add_index :promotions, :code, unique: true
  end
end
