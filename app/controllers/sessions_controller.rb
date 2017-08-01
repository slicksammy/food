class SessionsController < ActionController::Base

  def redirect_to_login_if_neccessary
    unless logged_in?
      session[:previous_url] = request.fullpath || default_redirect_url
      redirect_to '/signup'
    end
  end

  def redirect_from_login_if_necessary
    if logged_in?
      redirect_to '/store'
    end
  end

  def new
    unless user = User.find_by_lower_email(params[:email])
      return render status: 401, json: { error: 'email and password do not match' }
    end

    salt = user.salt

    if BCrypt::Engine.hash_secret(params[:password], salt) == user.encrypted_password
      session[:user_id] = user.id
      render statu: 202, nothing: true, json: { redirectUrl: '/store' }
    else
      render status: 401, json: { error: 'email and password do not match' }
    end
  end

  private

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
