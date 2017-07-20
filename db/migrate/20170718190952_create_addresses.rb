class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :street_number
      t.string :street_name
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :google_place_id

      t.timestamps
    end
  end
end
