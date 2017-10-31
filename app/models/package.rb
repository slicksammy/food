require 'uuid_helper'

class Package < ActiveRecord::Base
  include UUIDHelper
  serialize :products, Array

  scope :active, -> { where(active: [nil, true]) }

  validates :package_name, presence: true

  def add_product(product, amount)
    if has_product?(product)
      update_amount(product, amount)
    else
      self.products << map_product(product, amount)
    end

    self.save!
  end

  def update_amount(product, amount)
    self.products = self.products.delete_if { |p| p[:uuid] == product.uuid }
    self.products << map_product(product, amount)
  end

  def has_product?(product)
    self.products.find { |p| p[:uuid] == product.uuid }.present?
  end

  def map_product(product, amount)
    {uuid: product.uuid, amount: amount}
  end

  def price
    products.inject(0) { |sum, p| sum + Product.find_by_uuid(p[:uuid]).price*p[:amount] }
  end
end


