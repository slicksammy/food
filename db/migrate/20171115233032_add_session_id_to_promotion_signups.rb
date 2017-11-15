class AddSessionIdToPromotionSignups < ActiveRecord::Migration[5.1]
  def change
    add_column :promotion_signups, :session_id, :string
  end
end
