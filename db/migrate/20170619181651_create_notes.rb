class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.integer :place_id
      t.text :note_text

      t.timestamps
    end
  end
end
