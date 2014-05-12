 require "stripe"

Stripe.api_key = "sk_test_iP3SXMwi37dSGt24VLKiJ4RR"
STRIPE_PUBLIC_KEY = "pk_test_pzrCmuzBUkYp7c9oQrY8FU29"


Rails.configuration.stripe = {
  :publishable_key => ENV['sk_test_iP3SXMwi37dSGt24VLKiJ4RR'],
  :secret_key      => ENV['pk_test_pzrCmuzBUkYp7c9oQrY8FU29']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]


