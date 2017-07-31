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
      save_info!(token)
      # rescue Stripe::CardError => e
      #   body = e.json_body
      #   err  = body[:error]

      #   return err[:message]
      # end
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

    def save_info!(token)
      user.stripe_tokens.create!({
        token: token.id,
        last_4: token.card.last4,
        response: token,
        active: true
      })
    end
  end
end
