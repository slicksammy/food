class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, precision: 5, scale: 2
      t.string :image_url
      t.string :description
      t.string :uuid, index: true

      t.timestamps
    end
  end
end
