class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.integer :user_uuid, index: true
      t.string :status
      t.string :uuid, index: true

      t.timestamps
    end
  end
end
