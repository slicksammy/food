class CreatePackages < ActiveRecord::Migration[5.1]
  def change
    create_table :packages do |t|
      t.string :uuid, index: true
      t.text :products
      t.string :package_name
      t.boolean :active
      t.string :description

      t.timestamps
    end
  end
end
