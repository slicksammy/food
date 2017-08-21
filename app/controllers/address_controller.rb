class AddressController < SessionsController
  require 'delivery/availability'
  include CheckoutHelper

  before_action :permit_address_params, only: [:save]
  before_action :authorize!, except: [:check_availability] # do not create / view any addresses unless user is logged in

  # TODO delete when done testing
  def new
    # customer creates a new shipping address
  end

  def save
    if available? # only save address if we are available
      if 
        addr = current_user.addresses.create!(params["address"])

        render json: {uuid: addr.uuid}, status: 202
      else
        render json: { error: 'There was an error, please try again' }, status: 505
      end
    else
      # should throw an error with a description
      render json: {error: 'Unfortunately we do not deliver to your area yet' }, status: 505
    end
  end

  def available
    @signed_in = logged_in?
  end

  def check_availability    
    render status: 200, json: { available: available? }   
  end

  def get_for_user
    formatted_address = format_addresses(current_user.addresses)

    render json: { options: formatted_address }, status: 202
  end
  

  def permit_address_params
    params.require(:address).permit!
  end

  def available?
    ::Delivery::Availability.new(coordinates: params["coordinates"]).available?
  end
end
