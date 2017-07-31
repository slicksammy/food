require 'uuid_helper'

class Cart < ActiveRecord::Base
  include UUIDHelper

  has_many :carts_products, foreign_key: :cart_uuid, primary_key: :uuid
  has_many :products, through: :carts_products
  has_one :order, foreign_key: :cart_uuid, primary_key: :uuid
  belongs_to :user, foreign_key: :user_uuid, primary_key: :uuid

  def active_carts_products
    carts_products.select{ |p| p.amount > 0 }
  end

  def active_products
    active_carts_products.map(&:product)
  end
end
