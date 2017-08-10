class CreateOrderStatusLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :order_status_logs do |t|
      t.string :order_uuid, index: true
      t.string :status

      t.timestamps
    end
  end
end
