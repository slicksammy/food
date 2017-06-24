class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10
      t.string :google_place_id, unique: true
      t.string :name
      t.string :internal_type
      t.decimal :rating, :precision => 2, :scale => 1

      t.timestamps
    end
  end
end
