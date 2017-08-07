class CreatePasswordResetTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :password_reset_tokens do |t|
      t.string :user_uuid, index: true
      t.string :uuid, index: true
      t.boolean :used

      t.timestamps
    end
  end
end
