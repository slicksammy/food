class CreateJoinTablePlaceStatuses < ActiveRecord::Migration
  def change
    create_table :place_statuses do |t|
      t.integer :place_id, index: true
      t.integer :status_id, index: true

      t.timestamps
    end
  end
end
