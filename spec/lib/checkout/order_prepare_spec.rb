require 'checkout/order_prepare'
require 'rails_helper'

RSpec.describe Checkout::OrderPrepare do

  it 'creates the correct order' do
    User.new.save(validate: false)
    u = User.last
    c = Cart.create!(user: u)

    a = Address.create!(user: u)
    s = StripeToken.create!(user: u)

    p1 = Product.create!(price: 11)
    p2 = Product.create!(price: 10)

    CartsProduct.create!(product: p1, cart: c, amount: 1)
    CartsProduct.create!(product: p2, cart: c, amount: 1)


    order = Checkout::OrderPrepare.new(c).prepare

    expect(order.address).to eql(a)
    expect(order.subtotal).should_not be_nil
    expect(order.tax).should_not be_nil
    expect(order.shipping).should_not be_nil
    expect(order.total).should_not be_nil
  end

  it 'does not create a new order when one exists' do
    User.new.save(validate: false)
    u = User.last
    c = Cart.create!(user: u)

    a = Address.create!(user: u)
    s = StripeToken.create!(user: u)

    p1 = Product.create!(price: 11)
    p2 = Product.create!(price: 10)

    CartsProduct.create!(product: p1, cart: c, amount: 1)
    CartsProduct.create!(product: p2, cart: c, amount: 1)

    o = c.create_order!(:subtotal_cents => 11, :tax_cents => 11, :shipping_cents => 11, :total_cents =>11)


    order = Checkout::OrderPrepare.new(c).prepare

    expect(order).to eql(o)
    expect(Order.all.count).to eql(1)
  end
end
