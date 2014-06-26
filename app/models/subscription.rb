class Subscription < ActiveRecord::Base
  attr_accessible  :email,  :stripe_card_token, :stripe_customer_token, :token, :price

   attr_accessor :stripe_card_token

   
end



