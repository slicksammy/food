require 'checkout/order_totals'
require 'spec_helper'

RSpec.describe Checkout::OrderTotals do

  let(:cart) { instance_double(Cart, active_carts_products: [cart_product_1, cart_product_2]) }
  let(:cart_product_1) { instance_double(CartsProduct, amount: 1, product: product_1) }
  let(:cart_product_2) { instance_double(CartsProduct, amount: 2, product: product_2) }
  let(:product_1) { instance_double(Product, price: 10, name: 'steak', description: 'yummy', image_url: 'www.image.com') }
  let(:product_2) { instance_double(Product, price: 20, name: 'steak', description: 'yummy', image_url: 'www.image.com') }

  it 'calculates the correct totals' do
    totals = Checkout::OrderTotals.new(cart: cart).get_totals

    expect(totals[:subtotal]).to eq(50)
    expect(totals[:tax]).to eq(5)
    expect(totals[:shipping]).to eq(0)
    expect(totals[:total]).to eq(55)
  end

  it 'gets the correct items' do
    items = Checkout::OrderTotals.new(cart: cart).items

    expect(items.count).to eq(2)
  end
end
