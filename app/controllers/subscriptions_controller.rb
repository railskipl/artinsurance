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
      subscriber = params[:subscription][:email]
      addition_email = params[:addition_email]
      
      if addition_email.present?
        ArtMail.art_mail_2(session[:grades], subscriber, addition_email).deliver
      else
        ArtMail.art_mail(session[:grades], subscriber).deliver
      end
      session[:anualpremium] = nil
      session[:grades] = nil
      redirect_to @subscription, :notice => "Thank you for subscribing!"
    else
     render :new
    end
end

def feedback

  @user_feedback = { "rating" => params[:feedback][:rate],
              "comments" => params[:feedback][:comment], "from_email_address" => session[:email] }

  ArtMail.feedback_mail(@user_feedback).deliver

  session[:email] = nil
  flash[:notice] = "Thank you."
  redirect_to root_path

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
