require 'httparty'
require 'google/shared'

module Google
  class Coordinates
    include ::Google::Shared

    attr_reader :address

    URL = 'https://maps.googleapis.com/maps/api/geocode/json'

    def initialize(address)
      @address = address
    end

    # RETURN {"lat"=>33.096008, "lng"=>-33.786169}
    def convert
      params = {
        key: KEY,
        address: address
      }

      response = HTTParty.get(URL, query: params)
      
      response.parsed_response["results"].first["geometry"]["location"]
    end

    private

    # currently not being used but this is what you should use if you want to use google places api
    def convert_geo_to_string(geo_hash)
      "#{geo_hash["lat"]},#{geo_hash["lng"]}"
    end
  end
end
