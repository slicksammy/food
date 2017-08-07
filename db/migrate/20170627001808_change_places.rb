class ChangePlaces < ActiveRecord::Migration[5.1]
  def change
    add_column :places, :place_type_id, :integer
  end
end
