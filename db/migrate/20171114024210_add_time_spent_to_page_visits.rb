class AddTimeSpentToPageVisits < ActiveRecord::Migration[5.1]
  def change
    add_column :page_visits, :time_spent, :integer
  end
end
