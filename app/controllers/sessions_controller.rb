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

  private

  def current_user_uuid
    session[:user_uuid]
  end

  def logged_in?
    session[:user_uuid].present?
  end 

  def current_user
    User.find current_user_uuid
  end

  def default_redirect_url
    '/store'
  end
end
