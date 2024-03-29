require 'uuid_helper'

class User < ActiveRecord::Base
  include UUIDHelper

  has_many :addresses, foreign_key: :user_uuid, primary_key: :uuid
  has_many :stripe_tokens, foreign_key: :user_uuid, primary_key: :uuid
  has_many :carts, foreign_key: :user_uuid, primary_key: :uuid
  has_many :orders, through: :carts
  has_many :password_reset_tokens, primary_key: :uuid, foreign_key: :user_uuid
  has_one :admin, primary_key: :uuid, foreign_key: :user_uuid
  has_many :page_visits, primary_key: :uuid, foreign_key: :user_uuid
  has_one :stripe_customer, primary_key: :uuid, foreign_key: :user_uuid

  # validated on the front end
  # EMAIL_REGEX = /[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9][a-z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?/i

  # messages are formatted to what display on the front-end, slightly hacky but not a big deal
  validates :email, presence: { message: "Please enter an email" }, uniqueness: { message: "Email already in use", case_sensitive: false }#, format: { with: EMAIL_REGEX, message: "email is not a valid format" }
  validates :first_name, presence: { message: "Please enter a first name" }
  validates :last_name, presence: { message: "Please enter a last name" }
  # validates_length_of :password, minimum: 6, message: "password must be at least 6 characters long", if: :password_changed?
  scope :opted_in, -> { where(marketing_opt_in: true) }


  def self.create_with_password!(attributes, password)
    attributes[:salt] = BCrypt::Engine.generate_salt
    attributes[:encrypted_password] = BCrypt::Engine.hash_secret(password, attributes[:salt])

    User.create(attributes)
  end

  def self.find_by_lower_email(_email)
    where('lower(email) = ?', _email.downcase).first
  end

  def active_cart
    carts.ordered.ongoing.first
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def update_password!(password)
    encrypted_password = BCrypt::Engine.hash_secret(password, self.salt)

    self.update_attributes!(encrypted_password: encrypted_password)
  end

  def admin?
    admin.present?
  end

  def has_paid_orders?
    orders.completed.any?
  end
end
