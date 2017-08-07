require 'checkout/order_options'
require 'spec_helper'

RSpec.describe Checkout::OrderOptions do

  let(:cart) { instance_double(Cart, user: user) }
  let(:user) { instance_double(User, addresses: addresses, stripe_tokens: stripe_tokens) }
  let(:addresses) { double(ActiveRecord::Relation, klass: User) }
  let(:stripe_tokens) { double(ActiveRecord::Relation, klass: StripeToken) }
  let(:address_1) { instance_double(Address, city: 'Chicago') } 
  let(:address_2) { instance_double(Address, city: 'Northfield') }
  let(:stripe_token_1) { instance_double(StripeToken, token: 'token_1') } 
  let(:stripe_token_2) { instance_double(StripeToken, token: 'token_2') } 

  before do 
    allow(addresses).to receive(:ordered).and_return([address_1, address_2])
    allow(stripe_tokens).to receive(:ordered).and_return([stripe_token_1, stripe_token_2])
  end

  it 'gets the correct default address' do
    address = Checkout::OrderOptions.new(cart).default_address
    expect(address.city).to eq('Northfield')
  end

  it 'gets the correct default stripe_token' do
    stripe_token = Checkout::OrderOptions.new(cart).default_stripe_token
    expect(stripe_token.token).to eq('token_2')
  end

  it 'gets the correct default stripe_token' do
    stripe_token = Checkout::OrderOptions.new(cart).default_stripe_token
    expect(stripe_token.token).to eq('token_2')
  end

  it 'gets the correctly earliest_available_delivery_date' do
    # Time.stub_chain(:now, :hour).and_return(11)
    date = Checkout::OrderOptions.new(cart).earliest_available_delivery_date
    expect(date).to eql(Date.tomorrow)
  end
end
