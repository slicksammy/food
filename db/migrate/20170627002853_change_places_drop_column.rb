class ChangePlacesDropColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :places, :internal_type
  end
end
