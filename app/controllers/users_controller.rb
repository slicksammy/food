require 'checkout/order_totals'

class UsersController < SessionsController
  include CheckoutHelper

  before_action :permit_create_user_params, only: [:create]
  before_action :redirect_from_login_if_necessary, only: [:signup, :reset_password]
  before_action :redirect_to_login_if_neccessary, only: [:home]
  # before_action :redirect_from_login_if_necessary # don't create new user or view form if user already exists

  def signup
    @redirect_url = session[:previous_url] || '/'
  end

  def create
    u = User.create_with_password!(
      {
        first_name: params['firstName'],
        last_name: params['lastName'],
        email: params['email'],
        marketing_opt_in: params['marketing']
      },
      params["password"]
    )

    if u.errors.any?
      render status: 500, nothing: true, json: { errors: u.errors.messages }
    else
      session[:user_uuid] = u.uuid
      if cart
        cart.update_attributes(user: u)
      end

      begin
        UserMailer.welcome(u).deliver!
      rescue Net::SMTPFatalError, Net::OpenTimeout => e
        nil
      end

      render status: 200, json: { redirectUrl: session[:previous_url] }
    end
  end

  def forgot_password
    if u = User.find_by_lower_email(params["email"])
      p = PasswordResetToken.create!(user: u)
      UserMailer.password_reset(p).deliver!
    end

    render status: 202, body: nil
  end

  def reset_password
    token_uuid = params["token"]
    token = PasswordResetToken.find_by_uuid token_uuid

    if token && token.is_valid?
      @token = token_uuid
      render status: 202
    else
      @message = 'Your password reset link is no longer valid'
      render :file => 'public/nothing_here.html.erb'
    end
  end

  def reset_password!
    token_uuid = params["token"]
    token = PasswordResetToken.find_by_uuid token_uuid

    if token && token.is_valid?
      token.update_users_password!(params["password"])
      session[:user_uuid] = token.user_uuid
      render status: 200, body: nil
    else
      render status: 505, body: nil
    end
  end

  def get_promotion
    params.permit(:email, :promotion_code)

    if p = PromotionSignup.create_with_promotion_code!(params["email"], params["promotion_code"], session[:session_id])
      # Not Sending Email for Now
      # UserMailer.promotion_signup(p).deliver!
      render body: nil, status: 200
    else
      render body: nil, status: 200
    end
  end

  # def redirect_to_login_if_neccessary
  #   @redirect_url = '/checkout'
  #   super
  # end

  def home
    orders = current_user.orders.completed.ordered
    @orders = orders.map { |o| {order: format_order(o), items: to_string(o.products) } }
  end

  def permit_create_user_params
    params.permit(:firstName, :lastName, :email, :marketing, :password)
  end
end
