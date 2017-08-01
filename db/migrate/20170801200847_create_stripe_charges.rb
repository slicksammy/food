class CreateStripeCharges < ActiveRecord::Migration[5.1]
  def change
    create_table :stripe_charges do |t|
      t.string :order_uuid, index: true
      t.integer :amount_cents
      t.string :stripe_token_uuid, index: true
      t.string :status
      t.text :response

      t.timestamps
    end
  end
end
