# this class finds the distance between a plain text address, converts it to geo and finds distance to our 'epicenter'
# if the distance is less than the max radius than return true
require 'google/coordinates'
require 'delivery/distance'

module Delivery
  class Availability

    attr_reader :address, :coordinates, :distance

    def initialize(address: nil, coordinates: nil)
      @address = address
      @coordinates = coordinates
    end

    def available?
      convert_to_coordinates unless coordinates
      within_distance?
    end

    private

    def convert_to_coordinates
      @coordinates = ::Google::Coordinates.new(address).convert
    end

    def self.epicenter
      # "41.8936241,-87.6332896"
      {"lat"=>41.8936241, "lng"=>-87.6332896}
    end

    def self.max_radius
      # max distance
      2.5
    end

    def distance
      @distance = ::Delivery::Distance.calculate_distance(self.class.epicenter, coordinates)
    end

    def within_distance?
      distance <= self.class.max_radius
    end
  end
end
