class AddIndexOnSessionId < ActiveRecord::Migration[5.1]
  def change
    add_index :page_visits, :session_id
  end
end
