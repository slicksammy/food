class UsersController < SessionsController

  before_action :permit_create_user_params, only: :create
  before_action :redirect_from_login_if_necessary # don't create new user or view form if user already exists

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
      render status: 200, nothing: true, json: { redirectUrl: '/store' }
    end
  end

  def permit_create_user_params
    params.permit(:firstName, :lastName, :email)
  end
end
