class ChangePlaces < ActiveRecord::Migration
  def change
    add_column :places, :place_type_id, :integer
  end
end
