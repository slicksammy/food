# will probably have to add more fields to this

class CreateStripeTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :stripe_tokens do |t|
      t.integer :user_id, index: true
      t.integer :last_4
      t.string :token
      t.text :response
      t.boolean :active

      t.timestamps
    end
  end
end
