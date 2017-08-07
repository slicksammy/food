class CartsProduct < ActiveRecord::Base
  belongs_to :cart, foreign_key: :cart_uuid, primary_key: :uuid
  belongs_to :product, foreign_key: :product_uuid, primary_key: :uuid

  scope :for_product, ->(product) { where(product: product) }
end
