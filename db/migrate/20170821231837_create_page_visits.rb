class CreatePageVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :page_visits do |t|
      t.string :user_uuid
      t.string :url
      t.string :ip_address
      
      t.timestamps
    end
  end
end
