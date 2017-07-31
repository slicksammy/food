module StripeHelper
  def format_stripe_tokens(stripe_tokens)
    stripe_tokens.map{ |a| { value: a.uuid, display: format_stripe_token(a) } }
  end

  def format_stripe_token(stripe_token)
    stripe_token.formatted_last_4
  end
end
