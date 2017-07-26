class AddressController < SessionsController
  require 'delivery/availability'

  before_action :permit_address_params, only: [:save]
  before_action :redirect_to_login_if_neccessary # do not create / view any addresses unless user is logged in

  def new
    # customer creates a new shipping address
  end

  def save
    if available? # only save address if we are available
      current_user.addresses.create!(params["address"])

      render body: nil, status: 202
    else
      # should throw an error with a description
      render json: {error: 'Unfortunately we do not delivery to your area yet' }, status: 505
    end
  end
  

  def permit_address_params
    params.require(:address).permit!
  end

  def check_availability(&block)
    render status: 200, json: { available: available? }
  end

  def available?
    ::Delivery::Availability.new(coordinates: params["coordinates"]).available?
  end
end
