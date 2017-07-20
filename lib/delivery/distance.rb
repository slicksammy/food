# uses geocoordinates to calc distance

module Delivery
  class Distance

    EARTH_RADIUS = 3_959 # miles

    def self.calculate_distance(geo_1, geo_2)
      raise DeliveryDistanceError unless geo_1['lat'] && geo_1['lng'] && geo_2['lat'] && geo_2['lng']

      dlon = convert_degrees_to_radians(geo_2['lng']) - convert_degrees_to_radians(geo_1['lng']) 
      dlat = convert_degrees_to_radians(geo_2['lat']) - convert_degrees_to_radians(geo_1['lat'])
      a = (Math.sin(dlat/2))**2 + Math.cos(geo_1['lat']) * Math.cos(geo_2['lat']) * (Math.sin(dlon/2))**2 
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
