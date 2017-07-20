class PaymentsController < ActionController::Base
  
  # create a new card through stripe
  def new
    # see if this is already a strip customer User.has_stripe?
    # if has skip next part otherwise Stripe::Customer.new
    # wrap the above in a rescue block in case of error
    # show cc form and pass in stripe customer id
    # on the front end you make the api call with the data to stripe
  end

  def save_stripe_response
    # when customer creates account
    # when customer makes a payment
  end

  def choose_active_credit_card
    # find the active stripe token and make it active and deactivate the rest
  end

  def update
    # pass in StripeToken identifier and updates it as active (to use for the purchase)
    StripeToken.find(params["id"]).make_active_and_others_inactive!
  end
end
