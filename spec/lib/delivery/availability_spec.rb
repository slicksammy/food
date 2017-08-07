require 'rails_helper'
require 'spec_helper'
require 'delivery/availability'

RSpec.describe Delivery::Availability do

  let(:default_coordinates) { {"lat"=>41.8936241, "lng"=>-87.6332896} }

  describe 'google receives calls' do

    before do
      double = instance_double(Google::Coordinates, convert: default_coordinates)
      allow(Google::Coordinates).to receive(:new).with(anything).and_return(double)
    end

    it 'google receives call when plain text address' do
      expect(Google::Coordinates).to receive(:new)

      Delivery::Availability.new(address: '222 w merchandise mart plaza').available?
    end

    it 'google does not receive call when coordinates' do
      expect(Google::Coordinates).to_not receive(:new)

      Delivery::Availability.new(coordinates: default_coordinates).available?
    end
  end

  describe '.available' do

    # these coordinates are very far from our default coordinates
    it 'is not available' do
      expect(Delivery::Availability.new(coordinates: {"lat"=>45.8936241, "lng"=>-87.6332896}).available?).to eql(false)
    end

    it 'is not available' do
      expect(Delivery::Availability.new(coordinates: default_coordinates).available?).to eql(true)
    end
  end
end
