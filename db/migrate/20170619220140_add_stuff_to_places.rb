class AddStuffToPlaces < ActiveRecord::Migration[5.1]
  def change
    add_column :places, :phone_number, :string
    add_column :places, :address, :string
  end
end
