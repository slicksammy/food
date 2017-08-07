class CreateCallBacks < ActiveRecord::Migration[5.1]
  def change
    create_table :callbacks do |t|
      t.integer :place_id
      t.date :call_back_date
      t.boolean :called
    end
  end
end
