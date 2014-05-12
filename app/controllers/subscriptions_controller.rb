class SubscriptionsController < ApplicationController

	def new
    @subscription = Subscription.new(:token => params[:token], :price => params[:price],)
    if params[:PayerID]
      @subscription.price = params[:price]
      @subscription.paypal_customer_token = params[:PayerID]
      @subscription.email = @subscription.paypal.checkout_details.email
     end
    end
		
	

   

def create

      if params[:subscription][:paypal_payment_token].present?
       @subscription = Subscription.new(params[:subscription])
      else
        @subscription = Subscription.new(subscription_params)
      end

    if @subscription.save_with_payment
      redirect_to @subscription, :notice => "Thank you for subscribing!"
    else
     render :new
    end
   end

private

    def subscription_params
      if defined?(ActionController::StrongParameters)

      params.require(:subscription).permit(:email, :stripe_customer_token,:card_number,:card_code,:cardExpiryMonth,:cardExpiryYear)
     else
      params[:subscription]
     end
  end









end
