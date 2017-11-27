class CreateAvailabilityLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :availability_logs do |t|
      t.boolean :available

      t.string :lat
      t.string :lng
      t.string :session_id

      t.timestamps
    end
  end
end
