class UsersController < SessionsController
  include CheckoutHelper

  before_action :permit_create_user_params, only: :create
  before_action :redirect_from_login_if_necessary, only: :signup
  before_action :redirect_to_login_if_neccessary, only: :home
  # before_action :redirect_from_login_if_necessary # don't create new user or view form if user already exists

  def signup
    @redirect_url = session[:previous_url]
  end

  def create
    u = User.create_with_password!(
      {
        first_name: params['firstName'],
        last_name: params['lastName'],
        email: params['email']
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

      render status: 200, nothing: true, json: { redirectUrl: session[:previous_url] }
    end
  end

  def forgot_password
    if u = User.find_by_lower_email(params["email"])
      PasswordResetToken.create!(user: u)
    end

    render status: 202, body: nil
  end

  def reset_password
    token_uuid = params["token"]
    token = PasswordResetToken.find_by_uuid token_uuid

    if token && token.valid?
      @token = token_uuid
      render status: 202
    else
      @message = 'Nothing Here'
      render :file => 'public/nothing_here.html.erb', :layout => 'bootstrap'
    end
  end

  def reset_password!
    token_uuid = params["token"]
    token = PasswordResetToken.find_by_uuid token_uuid

    if token && token.valid
      token.update_users_password!(params["password"])
      render status: 202, body: nil
    else
      render status: 505, body: nil
    end
  end

  def home
    orders = current_user.orders
    @orders = orders.map { |o| {order: format_order(o), items: to_string(::Checkout::OrderTotals.new(order: o).items) } }
  end

  def permit_create_user_params
    params.permit(:firstName, :lastName, :email)
  end
end
