class CreateStripeCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :stripe_customers do |t|
      t.string :user_uuid
      t.string :stripe_customer_id

      t.timestamps
    end

    add_index :stripe_customers, :user_uuid
  end
end
