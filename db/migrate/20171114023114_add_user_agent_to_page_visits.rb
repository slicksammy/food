class AddUserAgentToPageVisits < ActiveRecord::Migration[5.1]
  def change
    add_column :page_visits, :user_agent, :text
  end
end
