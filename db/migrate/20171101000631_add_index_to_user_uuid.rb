class AddIndexToUserUuid < ActiveRecord::Migration[5.1]
  def change
    add_index :admins, :user_uuid
  end
end
