class ChangePlacesDropColumn < ActiveRecord::Migration
  def change
    remove_column :places, :internal_type
  end
end
