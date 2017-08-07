class SessionsController < ActionController::Base

  before_action :redirect_from_login_if_necessary, only: [:login]

  def authorize!
    unless logged_in?
      render status: 505
    end
  end

  def redirect_to_login_if_neccessary
    unless logged_in?
      session[:previous_url] = @redirect_url || '/store'
      redirect_to '/signup'
    end
  end

  def redirect_from_login_if_necessary
    if logged_in?
      redirect_to '/store'
    end
  end

  def logout
    session[:user_uuid] = nil

    redirect_to '/store' 
  end

  def login
    @redirect_url = request.referrer
  end

  def new
    unless user = User.find_by_lower_email(params[:email])
      return render status: 401, json: { error: 'email and password do not match' }
    end

    salt = user.salt

    if BCrypt::Engine.hash_secret(params[:password], salt) == user.encrypted_password
      session[:user_uuid] = user.uuid
      set_cart
      render status: 202, body: nil, json: { redirectUrl: '/store' }
    else
      render status: 401, json: { error: 'email and password do not match' }
    end
  end

  def set_cart
    if cart && current_user.active_cart  
      if current_user.active_cart != cart
        cart.merge_into!(current_user.active_cart)
        session[:cart_uuid] = current_user.active_cart.uuid
      end
    elsif !cart
       session[:cart_uuid] = current_user.active_cart.try(:uuid)
     else
      cart.update_attributes!(user: current_user)
    end
  end

  def cart_uuid
    session[:cart_uuid]
  end

  def current_user_uuid
    session[:user_uuid]
  end

  def logged_in?
    session[:user_uuid].present?
  end 

  def current_user
    User.find_by_uuid current_user_uuid
  end

  def cart
    Cart.find_by_uuid cart_uuid
  end

  def default_redirect_url
    '/store'
  end
end
