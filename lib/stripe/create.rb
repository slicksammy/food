# should add better error handling

require 'stripe'

module Stripe
  class Create

    attr_reader :params, :user

    def initialize(user, params)
      @params = params
      @user = user
    end

    def create!
      #begin
      token = create_token
      stripe_token = save_info!(token)
      stripe_customer = create_customer
      create_card!(stripe_token, stripe_customer)
      # rescue Stripe::CardError => e
      #   body = e.json_body
      #   err  = body[:error]

      #   return err[:message]
      # end
      stripe_token
    end

    # might want to add error handling here to show customer best message
    def create_token
      Stripe::Token.create(
        :card => {
          :number => params[:number],
          :exp_month => params[:month],
          :exp_year => params[:year],
          :cvc => params[:cvc]
        },
      )
    end

    def create_customer
      return user.stripe_customer if user.stripe_customer

      response = Stripe::Customer.create

      StripeCustomer.create!(user_uuid: user.uuid, stripe_customer_id: response.id)
    end

    def save_info!(token)
      user.stripe_tokens.create!({
        token: token.id,
        last_4: token.card.last4,
        response: token,
        active: true
      })
    end

    def create_card!(stripe_token, stripe_customer)
      customer = Stripe::Customer.retrieve(stripe_customer.stripe_customer_id)

      card = customer.sources.create(source: stripe_token.token)

      stripe_token.create_stripe_card(stripe_card_id: card.id)
    end
  end
end
