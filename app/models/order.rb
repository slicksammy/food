class Order < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :cart
  # belongs_to :user, through: :cart

  def confirm!
    self.status = 'confirmed'
    self.save!
  end

  def valid_expected_delivery_date?
    expected_delivery_date
  end


  def purchase!
    # process stripe token
  end

  def fulfill!
    # company has boxed the product
  end

  def deliver!
    # package has been delivered
  end

  def ask_for_refund!
    # customer has asked for refund
  end

  def refund!
    # product has been refunded
  end
end
