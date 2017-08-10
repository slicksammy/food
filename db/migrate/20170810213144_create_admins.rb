class CreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins do |t|
      t.string :user_uuid
      
      t.timestamps
    end
  end
end
