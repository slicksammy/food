# will probably have to add more fields to this

class CreateStripeTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :stripe_tokens do |t|
      t.string :user_uuid, index: true
      t.string :last_4
      t.string :token
      t.text :response
      t.boolean :active
      t.string :uuid, index: true

      t.timestamps
    end
  end
end
