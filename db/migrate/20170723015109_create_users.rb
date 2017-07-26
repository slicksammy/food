class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, index: true
      t.string :salt
      t.string :encrypted_password
      t.string :uuid, index: true

      t.timestamps
    end
  end
end
