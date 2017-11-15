class PromotionSignups < ActiveRecord::Migration[5.1]
  def change
    create_table :promotion_signups do |t|
      t.string :email
      t.integer :promotion_id

      t.timestamps
    end
  end
end
