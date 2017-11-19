class CreateEmailLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :email_logs do |t|
      t.string :email, index: true
      t.string :subject, index: true

      t.timestamps
    end
  end
end
