class Distance

  EARTH_RADIUS = 3_959 # miles

  attr_accessor :lat1, :lon1, :lat2, :lon2

  #TODO intialize class with 2 addresses and get there longitude and latitude

  def initialize(place1, place2)
    @lat1 = place1.latitude
    @lon1 = place1.longitude
    @lat2 = place2.latitude
    @lon2 = place2.longitude
  end

  def calculate_distance
    return nil unless lat1 && lon1 && lat2 && lon2 # cannot calculate distance unless we have all coordinates

    dlon = convert_degrees_to_radians(lon2) - convert_degrees_to_radians(lon1) 
    dlat = convert_degrees_to_radians(lat2) - convert_degrees_to_radians(lat1)
    a = (Math.sin(dlat/2))**2 + Math.cos(lat1) * Math.cos(lat2) * (Math.sin(dlon/2))**2 
    c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a) ) 
    d = EARTH_RADIUS * c
  end

  def convert_degrees_to_radians(degree)
    degree*Math::PI/180
  end

  def self.get_nearest_grocery_store
    grocery_stores = Place.grocery
    apartments = Place.apartment

    distance_hash = {}

    apartments.each do |apartment|
      distance = []
      grocery_stores.each do |store|
        d = new(store, apartment).calculate_distance
        distance << d
      end

      distance_hash[[apartment.name, apartment.id]] = distance.min
    end

    distance_hash.sort_by { |k,v| v }
  end

  def self.sort_stores(apartment)
    grocery_stores = Place.grocery#.select { |d| d.address.present? }

    output = {}

    grocery_stores.each do |store|
      d = new(store, apartment).calculate_distance
      output[store.name] = d
    end

    output.sort_by{ |k,v| v }
  end

end
