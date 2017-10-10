class AddSessionIdToPageVisits < ActiveRecord::Migration[5.1]
  def change
    add_column :page_visits, :session_id, :string
  end
end
