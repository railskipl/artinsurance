class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :email
      t.string :stripe_card_token
      t.string :token
      t.float  :price
      t.string :name
      t.string :stripe_customer_token
      t.string :card_number
      t.string :card_code
      t.string :cardExpiryMonth
      t.string :cardExpiryYear

      t.timestamps
    end
  end
end
