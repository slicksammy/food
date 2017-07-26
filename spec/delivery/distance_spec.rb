require 'rails_helper'
require 'spec_helper'
require 'delivery/distance'

RSpec.describe Delivery::Distance do

  describe '.calculate_distance' do

    it 'throws error' do
      expect { Delivery::Distance.calculate_distance({}, {}) }.to raise_error(Delivery::Distance::DeliveryDistanceError)
    end

    it 'calculates correctly' do
      distance = Delivery::Distance.calculate_distance({'lat': 43.5, 'lng': -87}.with_indifferent_access, {'lat': 43.4, 'lng': -86.4}.with_indifferent_access)
      rounded = distance.round(2)
      expect(rounded).to eql(30.88) # confirmed with a few other sources
    end
  end
end


