class SubscriptionsController < ApplicationController
  
  def new
    @subscription = Subscription.new(:token => params[:token], :price => params[:price])
    if params[:PayerID]
      @subscription.price = params[:price]
      @subscription.paypal_customer_token = params[:PayerID]
      @subscription.email = @subscription.paypal.checkout_details.email
     end
  end

  def create
    @subscription = Subscription.new(subscription_params)

    if params[:subscription][:stripe_card_token]

      @amount = (params[:subscription][:price]).to_f
      
      customer = Stripe::Customer.create(
        :email => params[:subscription][:email],
        :card  => params[:subscription][:stripe_card_token]
      )
     
      if is_number?(@amount.to_f)
        @amount = ((@amount.to_f)*100).to_i

        charge = Stripe::Charge.create(
          :customer    => customer.id,
          :amount      => @amount,
          :description => 'Rails Stripe customer',
          :currency    => 'usd'
        )
      end
     
      if charge[:id] && charge[:captured] == true
        @month = charge[:card][:exp_month]
        @year = charge[:card][:exp_year]
        @subscription.stripe_customer_token = charge[:customer] 
        subscriber = params[:subscription][:email]
        addition_email = params[:addition_email]
        if addition_email.present?
          ArtMail.art_mail_2(session[:grades], subscriber, addition_email, @subscription.stripe_customer_token).deliver
        else
          ArtMail.art_mail(session[:grades], subscriber, @subscription.stripe_customer_token).deliver
        end

        session[:anualpremium] = nil
        session[:grades] = nil
        redirect_to feedback_subscriptions_path, :notice => "Thank you for subscribing!"
      else
        
        render :new
        flash[:notice] = "Something went wrong,please try again. "
      end
    else
      render :new
      flash[:notice] = "Something went wrong,please try again. "
    end
  end

  def is_number?(i)
    true if Float(i) rescue false
  end

  def feedback

    @user_feedback = { "rating" => params[:feedback][:rate],
                "comments" => params[:feedback][:comment], "from_email_address" => session[:email] }

    ArtMail.feedback_mail(@user_feedback).deliver

    session[:email] = nil
    flash[:notice] = "We really appreciate your time to write us a comment. Thank you very much"
    redirect_to "http://www.artinsurancenow.com/"

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
