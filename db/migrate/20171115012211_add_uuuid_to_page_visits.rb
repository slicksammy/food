class AddUuuidToPageVisits < ActiveRecord::Migration[5.1]
  def change
    add_column :page_visits, :uuid, :string
    add_index :page_visits, :uuid
  end
end
