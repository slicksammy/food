class AddMarketingOptInToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :marketing_opt_in, :boolean
  end
end
