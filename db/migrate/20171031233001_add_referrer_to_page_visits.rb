class AddReferrerToPageVisits < ActiveRecord::Migration[5.1]
  def change
    add_column :page_visits, :referrer, :string
  end
end
