class AddIndexToPlaces < ActiveRecord::Migration
  def change
    add_index :places, :google_place_id, unique: true
  end
end
