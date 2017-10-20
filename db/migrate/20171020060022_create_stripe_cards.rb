class CreateStripeCards < ActiveRecord::Migration[5.1]
  def change
    create_table :stripe_cards do |t|
      t.string :stripe_token_uuid
      t.string :stripe_card_id

      t.timestamps
    end

    add_index :stripe_cards, :stripe_token_uuid
  end
end
