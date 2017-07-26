# uses geocoordinates to calc distance

module Delivery
  class Distance

    EARTH_RADIUS = 3959 # KM
    KM_TO_MILES = 1.609344

    def self.calculate_distance(geo_1, geo_2)
      raise DeliveryDistanceError unless geo_1['lat'] && geo_1['lng'] && geo_2['lat'] && geo_2['lng']

      dlon = convert_degrees_to_radians(geo_2['lng'].to_f) - convert_degrees_to_radians(geo_1['lng'].to_f) 
      dlat = convert_degrees_to_radians(geo_2['lat'].to_f) - convert_degrees_to_radians(geo_1['lat'].to_f)
      a = (Math.sin(dlat/2))**2 + Math.cos(convert_degrees_to_radians(geo_1['lat'].to_f)) * Math.cos(convert_degrees_to_radians(geo_2['lat'].to_f)) * (Math.sin(dlon/2))**2 
      c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a) ) 
      d = EARTH_RADIUS * c
    end

    def self.convert_degrees_to_radians(degree)
      degree*Math::PI/180
    end

    class DeliveryDistanceError < StandardError
    end

  end
end
