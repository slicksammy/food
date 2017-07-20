class Cart < ActiveRecord::Base
  has_many :carts_products
  has_many :products, through: :carts_products
  has_one :order

  def active_carts_products
    carts_products.select{ |p| p.amount > 0 }
  end

  def active_products
    active_carts_products.map(&:product)
  end
end
