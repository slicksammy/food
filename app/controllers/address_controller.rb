class AddressController < ActionController::Base
  require 'delivery/availability'

  before_action :permit_address_params, only: [:save]

  def new
    # customer creates a new shipping address
  end

  def save
    Address.create!(params["address"])

    render nothing: true, status: 202
  end
  

  def permit_address_params
    params.require(:address).permit!
  end

  def check_availability
    available = ::Delivery::Availability.new(coordinates: params["address"]).available?

    render status: 200, json: { available: available }
  end
end
