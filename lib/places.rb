require 'httparty'

class Places

  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  KEY = 'AIzaSyDy1VDR9d31XpZnkXQa-MSQ-fwD1nax8as'

  # attr_reader :location, :radius

  URL = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'

  COORDINATES_URL = 'https://maps.googleapis.com/maps/api/geocode/json'

  PLACE_URL = 'https://maps.googleapis.com/maps/api/place/details/json?'

  LASALLE_LOCATION = "41.8936241,-87.6332896" 

  DEFAULT_RADIUS = 2000

  def initialize(params, next_page_token: nil, count: 0) #keyword: keyword, location: LASALLE_LOCATION, radius: 2000, next_page_token: nil, count: 0, type: nil)
    @params = params

    @location = params[:location] ? self.class.to_coordinates(params[:location]) : LASALLE_LOCATION # must be in "latitude,longitude" format
    @radius = params[:radius] || DEFAULT_RADIUS # in meters
    @keyword = params[:keyword]
    @type = params[:type]
    @place_type_id = params[:place_type_id]

    @next_page_token = next_page_token
    @count = count
  end

  def get_and_save(should_loop=false)
    return if @count > 2

    results = get
    parsed_results = results.parsed_response["results"] # array of results
    parsed_results.each do |r|
      self.class.save_result(r, @place_type_id)
    end

    # commenting out bc next_page_token returned
    # loop by creating new instance and going again
    # byebug
    next_page_token = results.parsed_response["next_page_token"]
    self.class.new(@params, next_page_token: next_page_token, count: @count + 1).get_and_save(true) if should_loop && next_page_token
  end

  def get
    params = {
      key: KEY,
      location: @location,
      radius: @radius,
      keyword: @keyword,
      type: @type
      # next_page_token: @next_page_token
    }

    HTTParty.get(URL, query: params)
  end

  def self.to_coordinates(address, to_s=true)

    params = {
      key: KEY,
      address: address
    }

    response = HTTParty.get(COORDINATES_URL, query: params)

    geo_hash = response.parsed_response["results"].first["geometry"]["location"]

    convert_geo_to_string(geo_hash) if to_s
  end

  def self.convert_geo_to_string(geo_hash)
    "#{geo_hash["lat"]},#{geo_hash["lng"]}"
  end

  def self.save_result(result, type)
    params = {
      latitude: result["geometry"]["location"]["lat"],
      longitude: result["geometry"]["location"]["lng"],
      google_place_id: result["place_id"],
      name: result["name"],
      place_type_id: type,
      rating: result["rating"]
    }

    begin
      p = ::Place.create!(params)
      specific_place(p)
    rescue ActiveRecord::RecordNotUnique
    end
  end

  def self.specific_place(place)
    id = place.google_place_id

    params = {
      placeid: id,
      key: KEY
    }

    response = HTTParty.get(PLACE_URL, query: params)

    result = response.parsed_response["result"]

    place.update_attributes(phone_number: result["formatted_phone_number"], address: result["formatted_address"])
  end
end
