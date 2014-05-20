class Subscription < ActiveRecord::Base
  attr_accessible  :email,  :stripe_card_token, :stripe_customer_token, :token, :price

   attr_accessor :stripe_card_token

   def save_with_payment
    if valid?
       customer = Stripe::Customer.create(:email => email, :card => stripe_customer_token)
      self.stripe_customer_token = customer.id
      save!
       end
  end
end



