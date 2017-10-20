require 'uuid_helper'

class Cart < ActiveRecord::Base
  include UUIDHelper

  has_many :carts_products, foreign_key: :cart_uuid, primary_key: :uuid
  has_many :products, through: :carts_products
  has_one :order, foreign_key: :cart_uuid, primary_key: :uuid
  belongs_to :user, foreign_key: :user_uuid, primary_key: :uuid

  scope :ordered, -> { order("created_at DESC") }

  def active_carts_products
    carts_products.select{ |p| p.amount > 0 }
  end

  def active_products
    active_carts_products.map(&:product)
  end

  def self.ongoing
    select { |cart| cart.ongoing? }
  end

  def ongoing?
    !order || order.ongoing?
  end

  def add_product(product, amount)
    CartsProduct.find_or_create_by(cart_uuid: self.uuid, product_uuid: product.uuid).update_attributes!(amount: amount)
  end

  def merge_into!(keep)
    self.active_carts_products.each { |cp|
      if keep.products.include? cp.product
        cp_new = keep.carts_products.for_product(cp.product).first
        amount = cp_new.amount + cp.amount
        cp_new.update_attributes(amount: amount)
        cp.destroy!
      else
        cp.update_attributes!(cart: keep)
      end
    }

    self.destroy!

    keep.reload
  end
end
